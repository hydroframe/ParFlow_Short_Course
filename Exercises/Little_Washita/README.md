Little Washita PF-CLM Watershed Examples
=======
This folder contains run scripts and inputs to run the Little Washita test domain including examples for a parking lot test, spinup and running and restarting with ParFlow-CLM. The examples are setup to be run in order and walk through the steps of building a ParFlow-CLM model. A list of contents is provided below but its recommended that you refer to the ***Exercise Instructions*** below to walk through the materials contained here.  

Contents
--------------------
#### Run scripts
Scripts to run ParFlow and ParFlow CLM for the four exercises. Refer to ***Exercise Instructions*** for more information:
1. `LW_Exercise1.tcl`: Baseline PF-CLM run
2. `LW_Exercise2.tcl`: Parking lot
3. `LW_Exercise3.tcl`: Spinup
4. `LW_Exercise4.tcl`: ParFlow-CLM

#### PrePost_Processing
Tcl scripts for common pre and post processing steps used in the exercises.  
1. `Calc_Water_Balance.tcl`: Calculate total subsurface storage, surface storage, runoff and ET from model outputs.
2. `Dist_Forcings.tcl`: Distribute forcings to run on multiple processors (see **NLDAS**)
3. `File_Conversion.tcl`: Convert between pfb, sa and silo file types
4. `Flow_Calculation.tcl`: Calculate flow at a point.
5. `vtk_example.tcl`: Create terrain following vtk files from model outputs for visualization.


#### ParFlow_input
1. Slopes (`LW.slopex` & `LW.slopey`): Slopes in the x and y directions calculated from the dem.
2. subsurface Indicator File (`IndicatorFile_Gleeson.50z`): An indicator file for the subsurface geology.
3. Initial Pressure (`press.init`): A pressure file that reflects an initialized groundwater configuration (see **Exercise 2**). This is only required if you want to start your run for this initial condition.
4. Land Surface Elevations (`LW.dem`): Gridded elevation values.  Note this is only used for visualizing outputs and is not used direclty in the model.

File types:  Files are provided in both ParFlow formatted *.sa* files and *.pfb* files. Refer to `PrePost_Processing\File_Conversion.tcl` for and example of converting between *.sa*, *.pfb* and *.silo* files using pftools.

#### clm_input
Input files for clm:
1. drv_clmin.data - Driver file for CLM that has all the clm run settings.
2. drv_vegm.alluv.dat - Map of vegetation types for the Little Washita domain.
3. drv_vegp.dat - Vegetation parameters

#### NLDAS
120 hours of atmospheric forcing data to drive the model with.

Naming Convention: `NLDAS.variablename.starthour_to_endhour.extension`

File types: Forcings are provided in both ParFlow formatted *.sa* files and *.pfb* files. The *.pfb.dist* file are the distributed versions of the forcings needed to run on multiple processors. **NOTE:** Files are currently distributed to run on one processor. If you want to run on more cores you should run  `PrePost_Processing/Dist_Forcings.tcl` to redistribute the forcings before you do your model run.

Variables:
- APCP: Precipitation rate [mm/s]
- DLWR: Downward long wave radiation [W/m2
]
- DSWR: Downward short wave radiation [W/m2]
- Press: Atmospheric pressure [pa]
- SPFH: Water vapor specific humidity [kg/kg]
- Temp: Air temperature [K]
- UGRD: West-to-East component of wind [m/s]
- VGRD: South-to-North compoenent of wind [m/s]

Exercises
--------------------

### Exercise 1: My First ParFlow-CLM Run
1.	Copy Exercise 1 into your working directory
2.	Make a new directory called *run_dir*
3.	Copy the *LW_test.tcl* script from the tcl_Scripts folder to your run directory
4.	Run the tcl script:
`tclsh LW_test.tcl`

___
### Exercise 2: Parking lot Test
This exercise will walk through a parking lot test for testing overland flow.

1. Before you run the model, walk through the run script `LW_Exercise2.tcl` and answer the following:
  - How many time steps will this run for?
  - What is the hydraulic conductivity?
  - Is the subsurface homogeneous or heterogeneous?
  - How hard is it going to rain? And for how long?
  - What are the boundary conditions of the model?
  - Where are the outputs going to be written to?

2.	Run the simulation:
```
tclsh LW_Exercise2.tcl
```
  - You should be able to see outputs being written to your new Exercise2 folder and you can also track the progress by looking at the  *.kinsol.log* file

3.	Look at the pressure file outputs in visit:
```
•	File - Open
•	Add - Pseudocolor - pressure- Draw
•	Double click on the Pseudocolor to get the plot options. Change the min to 0 and the max to 0.05. Apply and Dismiss.
•	Use the time slider to advance through the simulation.
```

4.	Use PFTools to calculate the flow at the outlet using `PrePost_Processing/Flow_Calculation.tcl`
  - Change the run name, output directory and number of timesteps to process in the top of the script
```
tclsh Flow_Calculation.tcl
```

5.	Copy `flow_out.txt` that was created in step 3 into excel or open in R and plot the time series

###### Additional Tests to Run:
+	Change the run time, rainfall timing and magnitude
+	Change `Flow_Calculation.tcl` to look at the flow in alternate locations
+  Use the *set* command to set the slopex and slopey file names in the top of the tcl script. Then modify the rest of the script to refer to these new variables rather than using the complete file path.
+	Change the slope at the outlet of the domain and see how this changes the simulation (Hint: to do this you can convert your pfb slopes to text files using File_Conversion.tcl and manually change values. The outlet of the domain is at x=40, y=31)  

___
### Exercise 3: Spinup
This exercise will walk through the process of 'spinning up' a ParFlow simulation. It starts from a dry domain and applies a constant recharge forcing.

1. Before you run the model, walk through the run script `LW_Exercise3.tcl` and answer the following:
   - How long will this run for and what is the timestep?
   - Is the subsurface homogeneous or heterogeneous?
   - How does the hydraulic conductivity compare to ***Exercise 2***?
   - How is the surface flux for this case different from ***Exercise 2***?
   - Where is the initial condition set and what is it?
   - Where will the outputs of this run be written to?

2.	Run the first part of a spinup simulation starting the domain dry and applying a constant flux across the top of the domain with overland flow turned off:
```
tclsh LW_Exercise3.tcl
```
Look at the outputs from the spinup as they are written to see how the pressure field changes and look at the *kinsol.log* file to see how the model is converging.

3. Now we will run the second part of the spinup starting from our solution from Step 2 and turning overland flow on. If you have time, you should let the model from step 2 continue running until you have a steady state groundwater configuration, and use the final pressure file from that run as your initial condition for the this step. For now though, you can jump ahead and use the pressure file provided: `parflow_input/press.init.pfb`. In the tcl script you will need to change the following:
   -	turn off the overland flow spinup flag
   - Change the initial condition so it reads the *press.init.pfb file*\
   - Change the timing so that StopTime=200, DumpInterval=10.0 and TimeStep.Type=Constant
   - Change the runname of your simulation
Then run the simulation and look at the outputs
```
tclsh LW_Exercise3.tcl
```
###### Additional Tests to Run:
-	 Modify the Flow_Calculation.tcl scrip to create a time series of flow at the outlet and plot
- Try re-running Steps 2 or 3 using one of the outputs you generated in Step 2

____
### Exercise 4: Running ParFlow-CLM
Now that you have a spunup ParFlow model it is time to run ParFlow-CLM

1. Before you run the model, walk through the run script `LW_Exercise4.tcl` and answer the following:
   - How are the input files handled differently in this this run script than the previous exercises?
   - How many time steps will this exercise run for?
   - Where are the forcing files being read from?
   - What are the initial conditions for this run?
   - Where will the outputs of this run be written to?

2.	Decide on your processor topology and distribute your input files:
   - Set the Process.Topology keys in the  `PrePost_Processing/Dist_Forcings.tcl`
   - Distribute your forcing files
   ```
   cd PrePost_Processing
   tclsh Dist_Forcings.tcl
   ```
   - Set the Process.Topology keys in the `LW_Exercise4.tcl` to match what you used in the `Dist_Forcings.tcl`

3.	Run the Simulation
```
tclsh LW_Exercise4.tcl
```

4.	Look at outputs in Visit. Note that in addition to pressure and saturation there are all of the additional CLM output variables to look at.

5.	Calculate the water balance components and the flow at the outlet using `PrePost_Processing/Calc_Water_Blance.tcl` and `PrePost_Processing/Flow_Calculation.tcl`. Don't forget to change your run directory and runname in these scripts before you run. Use R or excel to look at the text outputs and look at the silos of water table depth in Visit.

6.	Make VTKs out of the outputs using `PrePost_Processing/VTK_example.tcl` and experiment with visualizations in Visit

____
### Exercise 5: Restarting ParFlow-CLM
N
Restarting:
Restart the run from where it left off. Note that because we are using the DailyRST flag, CLM only writes an output file once per day at midnight GMT.  This run started at midnight central time so the clm restart file will be written at hour 19.  Therefore, even though we ran for 24 hours we will need to roll back and restart at the last restart file. You can also see the restart time in clm_restart.tcl. To restart and run for another 24 hours you will need to change the following settings in the tcl script:
•	 TimingInfo.StartCount               19.0
•	pfset TimingInfo.StartTime                19.0
•	pfset TimingInfo.StopTime                 48.0
•	pfset Geom.domain.ICPressure.FileName        LW.out.press.00019.pfb
•	pfdist LW.out.press.00019.pfb
•	pfset Solver.CLM.IstepStart                           20
Also in drv_clmin.dat you should change:
•	startcode 	1
•	clm_ic  	1

Look at your outputs again. Don’t forget that you will need to change the number of time steps in the water balance and flow scripts.  You can ensure that you did the restart correctly by checking that the solution for the overlap period (i.e. hours 19-24) is the same for the first run and the restart run.

Additional Tests
Experiment with the model and outputs. Here are some suggestions:
•	Restart again and/or experiment with changing the CLM restart settings (Note that forcings are available up to hour 72)
•	Change the processor topology
•	Change the time step
•	Add additional variables to your water balance
•	Look at the forcing variables
•	Run again on BlueM
