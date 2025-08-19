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
<img width="805" height="437" alt="image" src="https://github.com/user-attachments/assets/6ecdb12c-d410-41f1-945a-5d2d9f0f0486" />

### 3. Simulation Objectives
- **Primary Goal**: Numerically validate mixing performance and throughput of the iLiNP micromixer  
  - Validation against literature (“Fine Tuning the Lipid Nanoparticle Size…”)  
  - Metrics: Output flow rate, mixing index, flow distribution  
- **Secondary Goal**: Develop a reusable simulation pipeline for commercial chip manufacture  
<img width="586" height="708" alt="image" src="https://github.com/user-attachments/assets/dbcbb057-d0ca-4215-8fad-c57b9a1a1caf" />

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
<img width="915" height="828" alt="image" src="https://github.com/user-attachments/assets/841eb463-6d98-4d95-ab1a-03ede0335477" />

### 5. Setup & Tutorials
- Lacked access to COMSOL/Ansys Fluent—chose OpenFOAM for full customization  
- Completed `pitzDaily` tutorial in Linux to learn file structure and terminal workflow  
- Followed Elbow Mixer tutorial (YouTube) to gain icoFoam proficiency  
<img width="1990" height="1117" alt="image" src="https://github.com/user-attachments/assets/ecfa1677-0656-47e4-86d0-42664be4dd2f" />

### 6. Reference Study (ACS Omega, 2018)
- **Geometry**: Channel ~3 mm length, 0.2 mm width, 0.1 mm height; baffles 150 µm width, 100 µm spacing (8–10 repeats)  
- **Flows**: 50, 100, 300, 500 µL/min (8.3×10⁻¹⁰ to 8.3×10⁻⁹ m³/s)  
- **Targets**: Mixing time <3 ms at peak flow; mixing index and pressure drop in 1,000–10,000 Pa range  
<img width="525" height="1125" alt="image" src="https://github.com/user-attachments/assets/b95f4973-2706-4462-b249-d4c37ea0a488" />

---

## Week 7 (14/08/2025) – Geometry Iterations & Validation

### 1. Simulation Approach
1. **Step 1**: T-junction mixer in Gmsh (`t_shape.geo`), extruded for 3D  
2. **Step 2**: Simplified baffled geometry inspired by iLiNP  
3. **Step 3**: Scale-up (×2, ×5 parallel channels) for back-pressure analysis  
4. **Step 4**: Full iLiNP validation with mixing/dilution  
<img width="1920" height="394" alt="image" src="https://github.com/user-attachments/assets/d29030cc-ca04-4a3a-bc05-82934158cbaa" />

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
<img width="978" height="508" alt="image" src="https://github.com/user-attachments/assets/9a255c8a-a45a-47e9-adb1-975b1ab18531" />
<img width="1967" height="623" alt="image" src="https://github.com/user-attachments/assets/ae1e5011-0e5d-4af0-ab82-eb249ea2a1cf" />

### 3. Key Iterations & Findings

#### Step 2 – Baffle Iteration 1
- Mesh errors from missing surfaces (“defaultFaces”)  
- Wrote a Python script to detect untagged geometry regions  
<img width="668" height="567" alt="image" src="https://github.com/user-attachments/assets/71ddbe56-aff4-4e28-a877-12f06308397b" />

#### Step 2 – Baffle Iteration 3 (Distance Function)
- Attempted graded mesh density via Gmsh distance function  
- No convergence improvement; longer solve times
<img width="332" height="254" alt="image" src="https://github.com/user-attachments/assets/0f79d614-6903-47a7-9688-b5443cae4cf4" />

#### Step 2 – Baffle Iteration 4
- Scaled geometry to microfluidic dimensions  
- Encountered high Courant number → stabilized by reducing `deltaT` and `endTime`  
<img width="1403" height="829" alt="image" src="https://github.com/user-attachments/assets/cd4e0e60-03c5-4129-b693-dc9fafc477ff" />

#### Step 2 – Post-Processing (`elbow_chip2.1.4_PP`)
- Generated streamlines for 50, 100, 500 µL/min in ParaView  
- No vortices observed at high flow—likely due to geometry, mesh, or timestep choices  
<img width="1012" height="569" alt="image" src="https://github.com/user-attachments/assets/f4a5959d-9974-48c6-92cd-9b7eb901df0e" />

#### Step 2 – Extended Run (`elbow_chip2.1.5`)
- Simulated closer to 3 ms; still no vortices → mixer geometry may not achieve 20 nm LNPs  
<img width="2111" height="1176" alt="image" src="https://github.com/user-attachments/assets/a5cabd30-4bf4-4c6f-a73b-9dd3a3884147" />

#### Step 2 – Throughput Validation
- ParaView integration measured 90.6 mL/min (over-estimated vs. 50 mL/min)  
- Simulated 0.083–0.167 m/s in ×5 parallel channels → 24.2 mL/min, matches literature range  
<img width="2000" height="1118" alt="image" src="https://github.com/user-attachments/assets/7898ac11-4e7a-4aec-881e-4a0d92bc97f8" />

#### Step 3 – Parallel Channels (`elbow_chip2.2`)
- Designed ×2 channel model; mesh error on physical surfaces  
- To-do: fix multiple-patch assignments in `.geo` file  
<img width="1953" height="1102" alt="image" src="https://github.com/user-attachments/assets/bd36ba0c-6707-4749-a9ac-6f823ad4e628" />

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
<img width="1991" height="1124" alt="image" src="https://github.com/user-attachments/assets/7b100bc9-bfd6-4543-a1c3-57b87a8a397f" />

## Documentation 
- I have created a GitHub repository to organise and showcase my project. 

*End of Project Evolution*  
