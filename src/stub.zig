// Copyright (c) 2025 GasFurr
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
const uefi = @import("std").os.uefi;

// Minimal UEFI types
pub fn main() void {
    const con_out = uefi.system_table.con_out.?;

    _ = con_out.reset(false) catch {};

    _ = con_out.outputString(&[_:0]u16{ 'H', 'e', 'l', 'l', 'o', ',', ' ' }) catch {};
    _ = con_out.outputString(&[_:0]u16{ 'w', 'o', 'r', 'l', 'd', '\r', '\n' }) catch {};

    const boot_services = uefi.system_table.boot_services.?;

    _ = boot_services.stall(5 * 1000 * 1000) catch {};
}
