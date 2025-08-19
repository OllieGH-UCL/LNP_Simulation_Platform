# LNP_Simulation_Platform

An OpenFOAM pipeline for designing and testing microfluidic mixer geometries (elbow_chip2.1.4_PP).  

**Features:**  
- Single-phase velocity & throughput verification  
- Two-phase VOF-based dilution studies (upcoming)  
- Automated mesh generation from Gmsh `.geo` files  
- Quick mesh-quality checks and ParaView post-processing  

---

## 🛠 Software Requirements

- Windows Subsystem for Linux (WSL)  
- OpenFOAM v2412  
- Gmsh  
- Notepad++ (or any text editor)  
- ParaView (`paraFoam` from terminal)  

---

## 📚 References

- Development of the iLiNP Device: Fine Tuning the Lipid Nanoparticle Size within 10 nm for Drug Delivery  
  https://pubs.acs.org/doi/10.1021/acsomega.8b00341  
- Mass production system for RNA-loaded LNPs using piled microfluidic devices  
  https://pubs.acs.org/doi/10.1021/acsomega.8b00341  

---

## 🏁 Quick Start: Velocity Simulation (elbow_chip2.1.4_PP)

**Design:** 9-baffle mixer based on iLiNP with minor geometry tweaks.  
- **Channel width:** 50 µm per inlet, 100 µm total.  


**Key commands:** `ls`, `cd`, `nano`, `gmsh`, `gmshToFoam`, `checkMesh`, `icoFoam`, `paraFoam`

1. **Create geometry & mesh**  
   - Open `geometry/t_shape.geo` in Gmsh, set `lc = 0.1`  
   - 1D → 2D → 3D mesh; fix any “curve loop” errors by ensuring all lines appear in the loop
     
2. **Export to OpenFOAM**
```
$ LIBGL_ALWAYS_SOFTWARE=1 gmsh geometry/t_shape.geo
$ gmsh geometry/t_shape.geo -3 -o run/test.msh
$ gmshToFoam run/test.msh
$ checkMesh # max non-orthogonality < 70°
```

4. **Run solver**  
```
$ icofoam
```
- Control **Courant number** via `system/controlDict`:  
  ```
  maxCo         1;         // maximum Courant number
  adjustTimeStep yes;      // adaptive time stepping
  ```
- If Co > 5, simulation aborts. To fix: refine mesh, reduce `deltaT`, or adjust inlet velocities.

4. **Post-process in ParaView**  
```
$ paraFoam # visualize p and U fields
```
- Load the case; click **Apply**.  
- Visualize **Pressure (p)** and **Velocity (U)** over time.  
- For streamlines, glyphs, or flow‐rate integration, see:  
  - Stream Traces & Glyphs: https://www.youtube.com/watch?v=aTDmesw9jxc  
  - Flow Rate & Plotting: https://www.youtube.com/watch?v=vgFL8kv320w  
- *Tip:* limit the number of time steps loaded to avoid performance issues.

---

## 📁 Folder Structure

elbow_chip2.1.4_PP/
│
├── 0/ ← Initial fields
│ ├── U ← Velocity boundary conditions
│ └── p ← Pressure boundary conditions
│
├── constant/ ← Mesh & material properties
│ ├── polyMesh/ ← gmshToFoam output
│ │ ├── boundary ← Patch definitions
│ │ ├── faces, points, owner, neighbour, cellZones, faceZones, pointZones
│ │ └── sets/fluid ← CellSet: fluid region
│ ├── transportProperties ← ν, D, etc.
│ └── turbulenceProperties.txt
│
├── geometry/ ← Gmsh .geo files
│ ├── t_shape.geo ← Base T-junction
│ ├── t_shape_2.geo ← Variation #2
│ ├── t_shape_3.geo ← Variation #3
│ └── t_shape_4.geo ← 9-baffle design
│
├── run/ ← Mesh & solver logs
│ ├── test.msh ← Gmsh mesh
│ ├── log.mesh ← gmshToFoam & checkMesh
│ ├── log.foam ← icoFoam output
│ ├── Allrun ← mesh→convert→solve script
│ └── Allclean ← clean-up script
│
├── system/ ← OpenFOAM dictionaries
│ ├── controlDict ← time stepping, write controls
│ ├── fvSchemes ← discretization schemes
│ ├── fvSolution ← solver settings & PISO
│ └── foamDataToFluentDict ← fields to export
│
├── *.geo.opt ← Gmsh optimization settings
├── error/ ← Error logs & screenshots
├── find_unnamed_surfaces.py ← Detect untagged curve loops
├── myenv_wsl ← WSL setup notes
└── test.msh ← Top-level mesh (duplicate)



- **0/** holds your `U` and `p` definitions.  
- **constant/polyMesh/** contains topology & zones after `gmshToFoam`.  
- **transportProperties** & **turbulenceProperties.txt** define fluid physics.  
- **geometry/** contains all Gmsh variants.  
- **run/** automates mesh generation and solver runs.  
- **system/** controls timestep, solvers, and export settings.  
- **Extras:** debugging scripts and WSL environment notes.

---

## 📐 Geometry Details

- **Meshing tip:** If loop isn’t closed, Gmsh reports “Curve loop is wrong.” Delete/redefine the loop in the GUI or script. Aim for non-orthogonality < 70°, skewness < 4.
- **Curve Loop errors:** Open Gmsh GUI → “Reload script” after edits → define Curve Loop → ensure closure.  
- **Physical groups:** Define separate Plane Surfaces for each patch: `inlet_1`, `inlet_2`, `outlet`, `wall_vertical`, `wall_horizental`, `frontAndBackPlanes`.

---

## 🚧 Common Errors

- **Multiple Physical Surfaces:** Assign each patch its own Plane Surface.  
- **Curve Loop Errors:** Ensure every boundary line appears exactly once in its loop.  
- **High Non-orthogonality (>70°):** Refine mesh or adjust geometry.  
- **High Courant Number (>5):** Reduce `deltaT` or refine mesh.

---

## 🔮 Next Steps

### Two-Phase Dilution Simulation

- Transition to `interFoam` or `twoPhaseEulerFoam` for ethanol–lipid mixing.  
- Automate parameter sweeps (inlet velocity, FRR, geometry) with shell scripts or GNU Parallel.  
- Validate pressure drop and mixing length against published iLiNP data.

---

## 📝 License & Contributions

Maintainer: Oliver Harper (<oliharps"gmail.com>)  

