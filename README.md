# LNP_Simulation_Platform

A turnkey OpenFOAM pipeline for designing and testing microfluidic mixer geometries (e.g., elbow_chip2.1.4_PP). It enables:
- Single‐phase velocity and throughput validation
- Two‐phase VOF‐based dilution studies (coming soon)
- Automated mesh generation from Gmsh .geo files
- Quick mesh‐quality checks and CFD post‐processing in ParaView

# Task 1 

Here I go through one can run a Velcoity and Pressure simulation for the first task of simulationg and testing a LNP mixer. 

Here I use the elbow_chip2.1.4_PP folder. 

# Details 
## 📂 Repository Structure
<img width="689" height="1083" alt="image" src="https://github.com/user-attachments/assets/b425b656-ccfb-40a7-a225-841c9a1598ad" />


## 🏁 Quick Start

Install prerequisites
- WSL (Windows Subsystem for Linux)
- OpenFOAM v2412
- Gmsh
- ParaView

Generate mesh and import into OpenFOAM
bash
cd elbow_chip2.1.4_PP
LIBGL_ALWAYS_SOFTWARE=1 gmsh geometry/t_shape.geo
gmsh geometry/t_shape.geo -3 -o run/test.msh
gmshToFoam run/test.msh
checkMesh
Run single‐phase simulation

bash
icoFoam

Visualize in ParaView

bash
paraFoam
🔧 Installation
1. Installing WSL
(Instructions TBD)

2. Installing OpenFOAM v2412
(Instructions TBD)

3. Installing Gmsh
bash
sudo apt update
sudo apt install gmsh
📐 Geometry Creation & Meshing
Open geometry/t_shape.geo in Gmsh.

Adjust lc (characteristic length); 0.1 works well.

Use Gmsh GUI to define points, connect lines, and create Curve Loops.

Define Plane Surfaces and Physical Groups (inlet_1, inlet_2, outlet, walls, frontAndBackPlanes).

Mesh: 1D → 2D → 3D.

If “Curve loop is wrong” error appears, ensure every line is in exactly one Curve Loop.

Export mesh for OpenFOAM (see Quick Start).

⚙️ Simulation Control
Edit files under system/:

controlDict

application icoFoam;

endTime 7e-6; deltaT 1e-8; maxCo 1; writeInterval 20;

fvSchemes – temporal & spatial schemes

fvSolution – solver settings, PISO correctors

foamDataToFluentDict – fields for Fluent export

Set boundary conditions in 0/U and 0/p:

text
U boundaryField
{
    inlet_1        fixedValue uniform (-0.1 0 0);
    inlet_2        fixedValue uniform ( 0.1 0 0);
    outlet         zeroGradient;
    wall_vertical  noSlip;
    wall_horizontal noSlip;
    frontAndBackPlanes empty;
}
🚧 Common Issues
Multiple Physical Surfaces: Assign each patch to exactly one Physical Surface.

Curve Loop Errors: Verify Curve Loop definitions include all and only closing lines.

High Courant Number: If maxCo exceeds ~1–5, reduce deltaT or refine mesh.

📖 References
Fine‐Tuning LNP Size: ACS Omega, 2018.

Mass Production of RNA‐Loaded LNPs: ACS Omega, 2018.
