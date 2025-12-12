<div align="center">


[![License: MPL v 2.0](https://img.shields.io/badge/license-MPL-2.0-orange)](https://choosealicense.com/licenses/mpl-2.0)
![GitHub commit activity](https://img.shields.io/github/commit-activity/m/GasFurr/ARCHI?color=green&branch=main)
![Version](https://img.shields.io/badge/version-0.0.1--alpha-yellow)

</div>


-----

> **⚠️ Live Fast Crash Harder**
> ArchiOS is an operating system for those who embrace exploration and are comfortable with a rapidly evolving, potentially unstable environment. It's for those who like to explore and aren't afraid of a bit of instability – the kind of adventurous user who sees `rm -rf /` as a fun starting point.

---

### Philosophy

(copied from ProtOS right now, working on refreshed version...)
ArchiOS embodies a fundamental rethinking of operating system design through core principles that challenge conventional approaches:

1. **Radical Pragmatism**  
   Unnecessary complexity is eliminated while effective solutions are preserved:
   - Legacy abstractions that hinder performance are removed
   - Functionality takes precedence over theoretical purity
   - Working solutions are maintained regardless of origin

2. **Hardware Intimacy**  
   Direct hardware interaction defines the system's foundation:
   - Low-level memory management enables maximum control
   - Bare-metal optimization minimizes abstraction layers
   - Modern hardware capabilities are fully leveraged

3. **Evolutionary Momentum**  
   The system deliberately breaks from the past to enable innovation:
   - Backward compatibility constraints are rejected
   - Continuous rolling-release development ensures rapid progress
   - "Build what's needed, remove what's not" guides legacy handling  
   [Learn about legacy in ARCHI](docs/legacy.md)

4. **User-Centric Empowerment**  
   Design prioritizes efficiency and understanding:
   - Keyboard-first interaction minimizes friction
   - Contextual tools (`new/edit/view/stat`) adapt to tasks
   - Clean visual aesthetic reduces cognitive load

5. **Open Innovation**  
   The architecture enables community-driven evolution:
   - Transparent development processes
   - Extensible core for deep customization
   - Collaborative improvement mechanisms

6. **Balanced Idealism**  
   Valuable concepts are preserved while limitations are rejected:
   - Unix principles are respected without being constrained
   - Historical technologies are intentionally evaluated
   - Practical value determines technology adoption

> This philosophy creates a computing experience that's faster, more controllable, and uniquely adaptable - where users become explorers rather than passive consumers.

ProtOS cultivates an environment where stability emerges from continuous refinement, power flows from direct hardware access, and freedom comes from shedding historical constraints. It represents a new approach where the operating system evolves with its users' needs rather than being bound by past decisions.

---

### Current Development Status

ProtOS is in its **very early alpha stages**. Basic foundational elements are being established, but most high-level features are still under development. Expect rapid changes and limited functionality for now.

---

### Technical Details

work in progress...

### Legal Stuff

Copyright © 2024 GasFurr. All rights reserved.

This Source Code Form is subject to the terms of the [Mozilla Public License, v. 2.0](https://mozilla.org/MPL/2.0/).

### What this means:
- You can use, modify, and distribute this software
- Modifications to existing MPL-licensed files must remain under MPL
- You must preserve copyright and license notices
- When distributing binaries, you must make source code available

See the [LICENSE](LICENSE) file for the complete terms.

ProtOS
> **🐉 Dragon's Note**  
> QEMU testing requires OVMF firmware. We don't ship it for the same reason
> dragons don't share gold: Lawyers. Get yours from
> [EDK2](https://github.com/tianocore/edk2) or `sudo pacman -S edk2-ovmf`
> then copy `OVMF_CODE.fd` to firmware folder. No hoard, no boot!

---

<div align="center"> 

`> w < /* Compiles through tears */`

**UNIX is user-friendly**
*It just hates you personally*
