# Overland Flow Exercise Instructions

**A**. Run each of the overland flow cases, capture the output and plot the hydrograph.

- Each case can be run by typing, e.g., `tclsh 1-d.overland.tcl` from the /overland directory level

1. `1-d.overland.tcl`
2. `dunne_flow.tcl`
3. `stormflow.tcl`
4. `heterogeneous.tcl`
5. `het-dunne.tcl`

*Q: if all the simulations have the same amount of rainfall, why are the runoff amounts different?*
**Determine the quantity of rain that falls on the domain and the quantity of water that leaves the domain for each case.  Then calculate the amount of water that stays in storage**

**B**. For the `1-d.overland.tcl` case, adjust the rainfall time (the duration of time over which it rains) so that it only rains for an hour of simulation time and replot the hydrograph.  

*Q: Why does the shape of the hydrograph looks as it does for this simulation?*
**Adjust the Manning's friction factor, re-run the simulation and replot the hydrograph.  Determine how Manning's n impacts the shape of the hydrograph**

**C**. Compare the `1-d.overland.tcl` and the `heterogeneous.tcl` simulation hydrographs and the `dunne_flow.tcl` and `het-dunne.tcl` simulation hydrographs.  
*Q: Why do the two sets of simulations have different hydrograph shapes?*
**C**. Modify the TCL scripts for `heterogeneous.tcl` and `het-dunne.tcl` so these two simulations produce the same hydrographs as `1-d.overland.tcl` and `dunne_flow.tcl`, respectively.  

*Q: What does subsurface storage have to do with the runoff response?*
**D**. Using ParaView, plot the saturation for `1-d.overland.tcl` and the `heterogeneous.tcl` simulations.  What are the differences?  Also using ParaView, plot the saturations for `dunne_flow.tcl` and `het-dunne.tcl` simulations.  What are the differences here?
