# LNP_Simulation_Platform

An OpenFOAM simulation pipeline for testing microfluidic channel geometries

It supports
- Single-phase velocity and throughput verification
- Two-phase VOF-based dilution studies (upcoming)
- Automated mesh generation from Gmsh geometries
- Quick visualization of mesh quality and flow fields

Software you need:
  - Install WSL
  - Install OpenFoam
  - Notepad ++ ... for editing files
  - Paraview ... used for postprocessing Openfoam files. If you set it up correctly, you can access it through terminal $parafoam

Papers:
- Development of the iLiNP Device: Fine Tuning the Lipid Nanoparticle Size within 10 nm for Drug DeliveryArticle: https://pubs.acs.org/doi/10.1021/acsomega.8b00341
- Mass production system for RNA-loaded lipid nanoparticles using piling up microfluidic devices: https://pubs.acs.org/doi/10.1021/acsomega.8b00341
  
# Quick Start Velocity Simulation - elbow_chip2.1.4_PP 

Key terminal commands: ls, cd -, cd .., nano 

“elbow_chip2.1.4_PP” design is a 9 baffle microfluidic mixer based on iLiNP with minor geometry changes due to lack of time. 

The following steps tell you how create a geometry, creates surfaces (e.g. inlets, outlets and walls), mesh and create a openfoam file for simulation. In the filder I provide the .geo file and mesh file which is the iLiNP baffle design. 

Geometry - T Juntion inlets with 50 micrometer channel width, 100 micrometre in total. 
Creating Geometry - run gmsh and open .geo file. Either use the UI to place Points, combien lines, or use the .geo file. Then Create a surface. Set the mesh value, named lc - I found 0.1 was the best for time and convergence. Extrude and create variable out = the extruded place surface. Define the physical volume fluid by setting it equal to out. Now create group selections. For this chip, patches include frontAndBackPlanes, walls_horizental, walls, vertical, outlet, inlet_1 and inlet_2. You can now go to options in the UI tab and select Visability. choose group selection and highlight each selection group individually and together, ensuirng all surfaces have been selected. If this is not done correctly, a patch/ surface error will occur. Note - you can update the UI with 'Reload script', this is helpful when you have edited the .geo file. Now for meshing, you hit 1D -> 2D-> 3D Mesh. If error occurs in the terimnal, its porbably becuase the Curve Loop is not closed/ doesn't contain all the lines to complete the loop. If this is the case, either go through each line and ensure its in the Closed Loop command, or delete the Closed Loop command and re-create the initial surface to ensure it contains all the lines. The mesh will appear in the UI but the mesh has not been created yet. 
Exporting Mesh - In some onlien tutorials, one can just exprt it, but this didn't work for me as it didn't create path names which are essential for boundary conditions. therefore you can run the followign commands to generate an OpenFoam file. When checking Mesh, __ should not exceed 70; usually if its high, it hints towards the simulaiton not converging or through a Courant number
  LIBGL_ALWAYS_SOFTWARE=1 gmsh geometry/t_shape.geo
  gmsh geometry/t_shape.geo -3 -o run/test.msh
  gmshToFoam run/test.msh
  checkMesh

Running Simulation - icoFoam & Courant number 
Run simulation with icofoam after checking mesh. depding in the End time and time step will change how long the solution takes. for this folder controlDict sets: 
  application     icoFoam;      // (or use pisoFoam for adaptive stepping & icoFoam for non-adaptive)
  startFrom       latestTime
  startTime       0;
  stopAt          endTime;
  endTime         7e-6;
  deltaT          1e-8;

Adidtionally, U is set too:
  dimensions      [0 1 -1 0 0 0 0];
  internalField   uniform (0 0 0);
  boundaryField
  {
      wall_vertical
      {
          type            noSlip;
      }
      inlet_1
      {
          type            fixedValue;
          value           uniform (-0.1  0 0);
      }
      inlet_2
      {
          type            fixedValue;
          value           uniform (0.1 0 0);
      }
      outlet
      {
          type            zeroGradient;
      }
      wall_horizental
      {
          type            noSlip;
      }
      frontAndBackPlanes
      {
          type            empty;
      }
  }

  P is set too:
dimensions      [0 1 -1 0 0 0 0];

internalField   uniform (0 0 0);

boundaryField
{
    wall_vertical
    {
        type            noSlip;
    }

    inlet_1
    {
        type            fixedValue;
        value           uniform (-0.1  0 0);
    }

    inlet_2
    {
        type            fixedValue;
        value           uniform (0.1 0 0);
    }

    outlet
    {
        type            zeroGradient;
    }

    wall_horizental
    {
        type            noSlip;
    }

    frontAndBackPlanes
    {
        type            empty;
    }
}

the velocities are set in accordance to the area of the inlets and the flow of the mentioned in the two papers above. More details in the powerpoint provided 

A common error encountered is the Courant number ("a dimensionless number used in Computational Fluid Dynamics (CFD) simulations to determine the stability of explicit numerical methods for solving partial differential equations"). In this folder simulations, the max is set to 5, If it exceeds, the simulation will stop. This was a signifianclty encountereted error for these simulations and is handled by changign different mesh, inlet velcoities and most important controlDict paramaters, inclduign the start, end and time step. i would reommend first finding paramters that ensure a solution, and then adapt that to your itended simulation case. 

Post Processing - Paraview 
Mentioned above, Paraview is the easiest option to see the solution of the simulaiton and do some post processing. Either open PV normally or type $paraview. select the OpenFoam format, hit the green Apply and toggel what you are seeing. for this simulation its Pressure (p), Velcotiy (U) at different time stamps. You can change the representing colours, I would recommend the one that scales them dependent on the data of the simulation, but bear in my mind that if you have alot of time steps, it will either take a very long time or crash! 
For more detailed post processing, such as streamlines, intgration for volumetric flow and graphing, refer to these tutorials 
- Stream Traces & Glyphs: https://www.youtube.com/watch?v=aTDmesw9jxc
- Flow Rate and plotting: https://www.youtube.com/watch?v=vgFL8kv320w

# Two Phase Dilution Simultion - Seeign whether your geometry mixes/dilutes to create LNP's
...TBD
- Two-Phase VOF Simulations
    ... Transition to interFoam or twoPhaseEulerFoam tutorials to model ethanol–water (or lipid solution) mixing.
- Parameter Studies
    ... Automate sweeping inlet velocity, FRR ratios, or baffle geometries using shell scripts or GNU parallel.
- Validation against Experiment
    ... Compare pressure drop and mixing length metrics to published data (e.g., iLiNP paper).

