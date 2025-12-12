// Copyright (c) 2025 GasFurr
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.

const std = @import("std");

pub fn build(b: *std.Build) void {
    // 1. Target Configuration (UEFI x86_64)
    const target = b.resolveTargetQuery(.{
        .cpu_arch = .x86_64,
        .os_tag = .uefi,
        .abi = .msvc,
    });
    const optimize = b.standardOptimizeOption(.{});

    // 2. Define the Kernel Module
    const root_mod = b.createModule(.{
        .root_source_file = b.path("src/stub.zig"),
        .target = target,
        .optimize = optimize,
        .code_model = .kernel, // Critical for higher half kernels later
        .red_zone = false,
        .strip = optimize != .Debug,
        .pic = true,
        .omit_frame_pointer = true,
    });

    // 3. Compile the Executable (Bootkernel)
    const kernel = b.addExecutable(.{
        .name = "bootx64",
        .root_module = root_mod,
    });

    // Install to zig-out/bin/bootx64.efi
    const install_step = b.addInstallArtifact(kernel, .{
        .dest_dir = .{ .override = .{ .custom = "efi/boot" } },
    });
    b.getInstallStep().dependOn(&install_step.step);

    // --- CUSTOM COMMANDS ---

    // COMMAND: zig build clear
    const clear_step = b.step("clear", "Nuke zig-cache and zig-out");
    const rm_cmd = b.addSystemCommand(&[_][]const u8{ "rm", "-rf", "zig-cache", "zig-out" });
    clear_step.dependOn(&rm_cmd.step);

    // COMMAND: zig build img
    // We delegate complex disk geometry to a shell script (Radical Pragmatism)
    const img_step = b.step("img", "Create a GPT disk image with FAT32 + EXT2");
    img_step.dependOn(b.getInstallStep()); // Build kernel first

    const img_cmd = b.addSystemCommand(&[_][]const u8{
        "bash", "scripts/make_image.sh",
    });
    img_step.dependOn(&img_cmd.step);

    // COMMAND: zig build run
    const run_step = b.step("run", "Run with QEMU (OVMF)");
    run_step.dependOn(img_step); // Ensure image exists

    const qemu_cmd = b.addSystemCommand(&[_][]const u8{
        "qemu-system-x86_64",
        "-nodefaults",
        "-vga",
        "std",
        "-machine", "q35,accel=kvm:tcg", // Try KVM, fall back to TCG
        "-m",       "256M",
        "-cpu",     "host",
        "-serial",  "stdio",

        // OVMF Firmware (Arch Linux paths)
        "-drive",   "if=pflash,format=raw,readonly=on,file=/usr/share/edk2-ovmf/x64/OVMF_CODE.4m.fd",
        // ignoring VARS for now, it needs the rights to write into OVMF_VARS.
        //"-drive",   "if=pflash,format=raw,file=/usr/share/edk2-ovmf/x64/OVMF_VARS.4m.fd",

        // The Disk Image
        "-drive",   "format=raw,file=zig-out/disk.img",
    });
    run_step.dependOn(&qemu_cmd.step);
}
