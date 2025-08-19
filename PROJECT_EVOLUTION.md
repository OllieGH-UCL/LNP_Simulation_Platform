# Project Evolution

This document chronicles the development of the LNP_Simulation_Platform over the course of the internship, detailing literature review, geometry and mesh iterations, solver setup, validation steps, and planned next phases.

---

## Week 6 (06/08/2025) – Foundations & Initial Simulations

### 1. Literature Review
Microfluidics is central to advanced pharmaceutical manufacturing, particularly for lipid nanoparticle (LNP) and lipid-based carrier synthesis. Key applications include:
- Drug and gene delivery vehicles (e.g., mRNA vaccines, oligonucleotide therapeutics)  
- Rapid, highly controllable, and scalable nanoparticle formulation  
- Improved mixing, formulation, and product uniformity compared with bulk methods  

### 2. Why iLiNP?
The iLiNP (innovative Lipid Nanoparticle Production) micromixer offers:  
- **Design flexibility & scalability**: Tune droplet size, mixing properties, and chip layout  
- **Mass-manufacturing compatibility**: Injection-molding for robust, repeatable fabrication  
- **Surface engineering**: Specialized coatings for reliable gasket sealing  

### 3. Simulation Objectives
- **Primary Goal**: Numerically validate mixing performance and throughput of the iLiNP micromixer  
  - Validation against literature (“Fine Tuning the Lipid Nanoparticle Size…”)  
  - Metrics: Output flow rate, mixing index, flow distribution  
- **Secondary Goal**: Develop a reusable simulation pipeline for commercial chip manufacture  

### 4. Solver & Equations
- **Solver**: icoFoam (transient, laminar, incompressible)  
  - PISO algorithm: Predict-correct coupling of velocity and pressure  
  - Assumptions: Laminar (Re << 100), Newtonian fluid, isothermal, incompressible  
- **Governing Equations**:  
  - Continuity (mass conservation)  
  - Momentum (Navier–Stokes)  
- **Boundary Conditions**:  
  - Inlets: Fixed velocity (`fixedValue`)  
  - Walls: No-slip  
  - Outlets: Zero-gradient velocity, fixed pressure  

### 5. Setup & Tutorials
- Lacked access to COMSOL/Ansys Fluent—chose OpenFOAM for full customization  
- Completed `pitzDaily` tutorial in Linux to learn file structure and terminal workflow  
- Followed Elbow Mixer tutorial (YouTube) to gain icoFoam proficiency  

### 6. Reference Study (ACS Omega, 2018)
- **Geometry**: Channel ~3 mm length, 0.2 mm width, 0.1 mm height; baffles 150 µm width, 100 µm spacing (8–10 repeats)  
- **Flows**: 50, 100, 300, 500 µL/min (8.3×10⁻¹⁰ to 8.3×10⁻⁹ m³/s)  
- **Targets**: Mixing time <3 ms at peak flow; mixing index and pressure drop in 1,000–10,000 Pa range  

---

## Week 7 (14/08/2025) – Geometry Iterations & Validation

### 1. Simulation Approach
1. **Step 1**: T-junction mixer in Gmsh (`t_shape.geo`), extruded for 3D  
2. **Step 2**: Simplified baffled geometry inspired by iLiNP  
3. **Step 3**: Scale-up (×2, ×5 parallel channels) for back-pressure analysis  
4. **Step 4**: Full iLiNP validation with mixing/dilution  

### 2. Files & Versions
- **elbow_chip2**: Baseline T-junction  
- **elbow_chip2.1**: Improved mesh & parameters  
- **elbow_chip2.1.1**: Shortened single baffle  
- **elbow_chip2.1.2**: Full baffle series  
- **elbow_chip2.1.3**: Baffles + distance-based mesh refinement  
- **elbow_chip2.1.4**: Microfluidic-scale baffle with literature parameters  
- **elbow_chip2.1.4_PP**: Post-processed in ParaView (streamlines, diagrams)  
- **elbow_chip2.1.5**: Extended simulation time (closer to 3 ms)  
- **elbow_chip2.2**: ×2 parallel baffle design (mesh error investigation)  

### 3. Key Iterations & Findings

#### Step 2 – Baffle Iteration 1
- Mesh errors from missing surfaces (“defaultFaces”)  
- Wrote a Python script to detect untagged geometry regions  

#### Step 2 – Baffle Iteration 3 (Distance Function)
- Attempted graded mesh density via Gmsh distance function  
- No convergence improvement; longer solve times  

#### Step 2 – Baffle Iteration 4
- Scaled geometry to microfluidic dimensions  
- Encountered high Courant number → stabilized by reducing `deltaT` and `endTime`  

#### Step 2 – Post-Processing (`elbow_chip2.1.4_PP`)
- Generated streamlines for 50, 100, 500 µL/min in ParaView  
- No vortices observed at high flow—likely due to geometry, mesh, or timestep choices  

#### Step 2 – Extended Run (`elbow_chip2.1.5`)
- Simulated closer to 3 ms; still no vortices → mixer geometry may not achieve 20 nm LNPs  

#### Step 2 – Throughput Validation
- ParaView integration measured 90.6 mL/min (over-estimated vs. 50 mL/min)  
- Simulated 0.083–0.167 m/s in ×5 parallel channels → 24.2 mL/min, matches literature range  

#### Step 3 – Parallel Channels (`elbow_chip2.2`)
- Designed ×2 channel model; mesh error on physical surfaces  
- To-do: fix multiple-patch assignments in `.geo` file  

---

## Challenges & Resolutions
- **Mesh Quality**: Non-orthogonality and default faces → refined Gmsh scripts and tagging  
- **Courant Number**: Reduced `deltaT`, adopted adaptive time stepping (PISO)  
- **Solver Stability**: Considering transition to `pisoFoam` and `scalarTransportFoam` for mixing simulations  

---

## Next Steps
1. **Two-Phase VOF Simulations**: Model ethanol–water mixing in `interFoam`  
2. **Parameter Sweeps**: Automate inlet velocity, FRR, and geometry variations with scripts or GNU Parallel  
3. **Experimental Validation**: Compare pressure drop and mixing length metrics with published data  
4. **Manufacturing & CAD**: Prototype chip, holder, and gasket; plan injection molding FEA  

---

## Week 8 (19/08/2025) – Geometry Iterations & Validation

## CAD Files 
- I have created Fusion360 CAD files for a unit based microfluidic chip based on the simulations design.
- The design includes an injection moulded chip, multiple film layers for sealing, aluminium casing for stacking and a inlet/outlet removable funnl system.

## Documentation 
- I have created a GitHub repository to organise and showcase my project. 

*End of Project Evolution*  
