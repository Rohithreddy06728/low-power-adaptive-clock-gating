Low-Power Adaptive Clock Gating Controller

Project Presentation Video

Watch my project presentation:

"▶ Watch the Project Video on Google Drive" (https://drive.google.com/file/d/1DKu0iaJRe8XMTfTUGIQZ9LqK0E9byMjH/view?usp=drivesdk)

Project Overview

This project demonstrates a three-channel Low-Power Adaptive Clock Gating Controller implemented using Verilog RTL and the SKY130 standard-cell library.

The controller independently manages three gated clock outputs using request signals, idle detection, and wake-up control.

Tools and Technologies

- Verilog HDL
- SKY130 PDK
- Yosys synthesis
- OpenSTA static timing analysis
- OpenLane physical design
- GTKWave simulation
- KLayout GDS inspection

Key Results

- All five functional simulation test cases passed.
- Synthesis produced 57 mapped cells, including three integrated clock-gating cells.
- Pre-layout timing analysis reported positive worst negative slack across three PVT corners.
- Saved physical-verification reports show zero Magic DRC violations, zero LVS errors, and zero antenna violations.

Timing results are pre-layout. Physical-verification results refer to the saved reports for this design run.

Project Screenshots

- "Simulation Waveform" (docs/screenshots/simulation_waveform.png)
- "Synthesis Results" (docs/screenshots/synthesis_results.png)
- "Final GDS Layout" (docs/screenshots/final_gds_layout.png)
- "Routed Physical Design" (docs/screenshots/routed_layout.png)
- "Functional Verification" (docs/screenshots/verification_results.png)
- "Physical Verification" (docs/screenshots/physical_verification.png)

Main Repository

"View Source Code and Project Files" (https://github.com/Rohithreddy06728/low-power-adaptive-clock-gating)
