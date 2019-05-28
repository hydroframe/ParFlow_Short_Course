Exercise 4: Running and restarting a ParFlow-CLM model

Running a PF-CLM model:
1.	Decide on your processor topology:
•	 Set Process.Topology keys in tcl_scripts/LW_Test.tcl 
•	Do the same in tcl_scripts/Dist_Forcings.tcl
•	Run Dist_Forcings.tcl to distribute the meteorological forcings
2.	Run LW_Test.tcl. This is setup to run for 24 hours. Use cat or tail to look at the kinsol.log file and see the progress and solver performance.  
3.	Look at outputs in Visit. Note that in addition to pressure and saturation there are all of the additional CLM output variables to look at.  
4.	Calculate the water balance components and the flow at the outlet using Calc_Water_Blance.tcl and Flow_Calculation.tcl. Use R or excel to look at the text outputs and look at the silos of water table depth in Visit. 
5.	Make VTKs out of the outputs using VTK_example.tcl and experiment with visualizations in Visit

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

Preliminary Steps for running on BlueM:
1.	Log into aun
ssh –X <username>@bluem.mines.edu
ssh –X aun
cd scratch
2.	Copy the exercise 2 folder
cp -r /u/me/le/lcondon/scratch/Exercise2 .
cd Exercise2/tclscripts
3.	Set the PARFLOW_DIR environment variable
export PARFLOW_DIR=/u/st/fl/jagilber/bins/ParF/PFv893

