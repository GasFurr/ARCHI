<div align="center">

# ArchiOS
**The Desktop-Pure Computing Environment.**
*IBM Industrial Design. Bauhaus Geometry. Zig Performance.*

[![License: MPL v 2.0](https://img.shields.io/badge/license-MPL-2.0-orange)](https://choosealicense.com/licenses/mpl-2.0)
![Version](https://img.shields.io/badge/version-0.0.1--alpha-yellow)

</div>

-----

> **⚠️ Live Fast, Crash Harder.**
> ArchiOS is for those who embrace exploration and aren't afraid of a bit of instability—the kind of adventurous user who sees `rm -rf /` as a fun starting point. ArchiOS is a desktop-pure, 2015+ baseline operating system. It is not for servers, it is not for phones, and it is not for the faint of heart. It is a hobby for those who want to reclaim the act of **Computing**

---

### Philosophy

ArchiOS embodies a fundamental rethinking of operating system design through core principles that challenge conventional approaches:

1. **Radical Pragmatism** Unnecessary complexity is eliminated while effective solutions are preserved. Legacy abstractions that hinder performance are removed. Functionality takes precedence over theoretical purity.

2. **Hardware Intimacy (2015+ Baseline)** Direct hardware interaction defines the foundation. We optimize for **NVMe, UEFI, and 64-bit Multicore**. Backward compatibility for pre-2015 hardware is rejected to ensure a lean, bare-metal optimized system.

3. **Evolutionary Momentum** The system deliberately breaks from the past to enable innovation. "Build what's needed, remove what's not" guides our handling of legacy. ArchiOS is a desktop-pure environment; it does not target servers, mobile, or legacy hardware.

4. **User-Centric Empowerment** Design prioritizes efficiency and direct control. Interaction is keyboard-first, utilizing a "Down-Top" terminal where history flows upward from a pinned input line. Contextual tools (`new`, `edit`, `view`, `stat`) replace fragmented Unix utilities.

5. **Open Innovation** The architecture enables community-driven evolution through a transparent development process. The system remains purely offline regarding telemetry—your data and your logs stay local.

---

### Current Development Status

ArchiOS is currently in the **Architectural Planning / Pre-Alpha phase**. 

- [x] Philosophy and Design Specification
- [/] UEFI Bootloader Stub (Hello World)
- [ ] Static Core (Bunker) Implementation
- [ ] Microkernel IPC and Capability Handshaking
- [ ] GPU-Accelerated Terminal Interface

The project is currently a "living blueprint." Expect rapid changes to the specification and foundational code.

---

### Technical Details

| Component | Specification |
| :--- | :--- |
| **Language** | Zig |
| **Kernel** | Hybrid Microkernel (Static Core + Isolated Modules) |
| **Scheduler** | MuQSS (Multi-Queue Skip-List Scheduler) |
| **Graphics** | Direct-Draw Vector Surface (No X11/Wayland) |
| **Baseline** | x86_64, UEFI 2.5+, NVMe Storage |

---

### Legal

Copyright © 2025 GasFurr. All rights reserved.

This Source Code Form is subject to the terms of the [Mozilla Public License, v. 2.0](https://mozilla.org/MPL/2.0/).

**Key Terms:**
- Modifications to MPL-licensed files must remain under the MPL.
- You must preserve all copyright and license notices.
- Binaries must be accompanied by source code availability.


---

<div align="center"> 

`> w < /* The Librarian is watching */`

**Computing as an Intent, not a Service.**

</div>
