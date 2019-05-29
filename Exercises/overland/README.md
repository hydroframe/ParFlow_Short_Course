# Overland Flow and Runoff Generation Mechanisms Examples
Each of these examples simulates a different runoff mechanism over a simple hillslope using ParFlow.  They are:


1. `1-d.overland.tcl` a Hortonian overland flow example
2. `dunne_flow.tcl` a Dunne overland flow example
3. `stormflow.tcl` a subsurface stormflow example
4. `heterogeneous.tcl` a heterogeneous Hortonian example (Kg=rainfall)
5. `het-dunne.tcl` a heterogeneous Dunne example (Kg>rainfall)


+ Each case can be run by typing, e.g., `tclsh 1-d.overland.tcl` from the /overland directory level
+ Each case generates the outflow from the domain as output for plotting.  This can be copied and pasted into a worksheet or piped into a text file for plotting in a script-based framework (e.g. Python, R, etc).
+ To work the exercise, refer to the instructions in `How-To-Overland.md` which will walk you through running the cases and manipulating the inputs to experiment.
