LW Exercise 3 – Spinup

1.	Run the first part of a spinup simulation starting the domain dry and applying a constant flux across the top of the domain with overland flow turned off
-	Copy LW_Exercise3 folder from Powell to where you will be running locally
scp guestxx@powell.mines.edu:/data/ParFlow_Short_Course2018/LW_Exercise3.tar .
-	Run the spinup tclsh LW_SpinupTest.tcl
-	Look at the outputs as they are generated
-	Look at the kinsol log file


2.	Run the second part of spinup 
-	Edit the LW_SpinupTest.tcl script: 
o	turn off the overland flow spinup flag
o	Change the initial condition so it reads the press.init.pfb file 
o	Change the runname of your simulation
-	Run the LW_SpinupTest.tcl
-	Look at the outputs
-	Modify the Flow_Calculation.tcl scrip to create a timeseries of flow at the outlet and plot

