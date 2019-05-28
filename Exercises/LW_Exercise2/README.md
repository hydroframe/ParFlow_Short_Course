Exercise 1: Parking Lot Test

Initial Run:
1.	Run the tcl script  LW_ParkingLotTest.tcl
2.	Look at the pressure file outputs in visit:
•	File - Open
•	Add - Pseudocolor - pressure- Draw
•	Double click on the Pseudocolor to get the plot options. Change the min to 0 and the max to 0.05. Apply and Dismiss.
•	Use the time slider to advance through the simulation.
3.	Use PFTools to calculate the flow at the outlet using Flow_Calculation.tcl
4.	Copy flow_out.txt into excel or open in R and plot the time series

Additional Tests:
1.	change the run time, rainfall timing and magnitude
2.	look at the flow in alternate locations
3.	Change the slope at the outlet of the domain and see how this changes the simulation (Hint: to do this you can convert your pfb slopes to text files using File_Conversion.tcl and manually change values. The outlet of the domain is at x=40, y=31)  
