# SCRIPT TO RUN A PARKING LOT TEST FOR THE LITTLE WASHITA

# Import the ParFlow TCL package
lappend   auto_path $env(PARFLOW_DIR)/bin
package   require parflow
namespace import Parflow::*

pfset     FileVersion    4

#-----------------------------------------------------------------------------
# Setup run name and location
#-----------------------------------------------------------------------------
file mkdir Exercise2
cd Exercise2
set runname "LW_ParkingLot"
pfset TopoSlopes.Elevation.FileName ../parflow_input/LW.dem.pfb 

#-----------------------------------------------------------------------------
# Set Processor topology
#-----------------------------------------------------------------------------
pfset Process.Topology.P 1
pfset Process.Topology.Q 1
pfset Process.Topology.R 1

#-----------------------------------------------------------------------------
# Computational Grid
#-----------------------------------------------------------------------------
pfset ComputationalGrid.Lower.X           0.0
pfset ComputationalGrid.Lower.Y           0.0
pfset ComputationalGrid.Lower.Z           0.0

pfset ComputationalGrid.DX                1000.0
pfset ComputationalGrid.DY                1000.0
pfset ComputationalGrid.DZ                2.0

pfset ComputationalGrid.NX                41
pfset ComputationalGrid.NY                41
pfset ComputationalGrid.NZ                50


#-----------------------------------------------------------------------------
# Names of the GeomInputs
#-----------------------------------------------------------------------------
pfset GeomInput.Names                     "box_input"

#-----------------------------------------------------------------------------
# Domain Geometry Input
#-----------------------------------------------------------------------------
pfset GeomInput.box_input.InputType      Box
pfset GeomInput.box_input.GeomName      domain

#-----------------------------------------------------------------------------
# Domain Geometry
#-----------------------------------------------------------------------------
pfset Geom.domain.Lower.X                        0.0
pfset Geom.domain.Lower.Y                        0.0
pfset Geom.domain.Lower.Z                        0.0

pfset Geom.domain.Upper.X                        41000.0
pfset Geom.domain.Upper.Y                        41000.0
pfset Geom.domain.Upper.Z                          100.0
pfset Geom.domain.Patches             "x-lower x-upper y-lower y-upper z-lower z-upper"

#-----------------------------------------------------------------------------
# Permeability (values in m/hr)
#-----------------------------------------------------------------------------
pfset Geom.Perm.Names                     "domain"

pfset Geom.domain.Perm.Type           Constant
pfset Geom.domain.Perm.Value          0.000001

pfset Perm.TensorType                     TensorByGeom
pfset Geom.Perm.TensorByGeom.Names        "domain"
pfset Geom.domain.Perm.TensorValX         1.0d0
pfset Geom.domain.Perm.TensorValY         1.0d0
pfset Geom.domain.Perm.TensorValZ         1.0d0

#-----------------------------------------------------------------------------
# Specific Storage
#-----------------------------------------------------------------------------
pfset SpecificStorage.Type                Constant
pfset SpecificStorage.GeomNames           "domain"
pfset Geom.domain.SpecificStorage.Value   1.0e-5

#-----------------------------------------------------------------------------
# Phases
#-----------------------------------------------------------------------------
pfset Phase.Names                         "water"
pfset Phase.water.Density.Type            Constant
pfset Phase.water.Density.Value           1.0
pfset Phase.water.Viscosity.Type          Constant
pfset Phase.water.Viscosity.Value         1.0

#-----------------------------------------------------------------------------
# Relative Permeability
#-----------------------------------------------------------------------------
pfset Phase.RelPerm.Type                  VanGenuchten
pfset Phase.RelPerm.GeomNames             "domain"

pfset Geom.domain.RelPerm.Alpha           3.5
pfset Geom.domain.RelPerm.N               2.0

#-----------------------------------------------------------------------------
# Saturation
#-----------------------------------------------------------------------------
pfset Phase.Saturation.Type               VanGenuchten
pfset Phase.Saturation.GeomNames          "domain"

pfset Geom.domain.Saturation.Alpha        3.5
pfset Geom.domain.Saturation.N            2.
pfset Geom.domain.Saturation.SRes         0.2
pfset Geom.domain.Saturation.SSat         1.0

#-----------------------------------------------------------------------------
# Porosity
#-----------------------------------------------------------------------------
pfset Geom.Porosity.GeomNames             "domain"

pfset Geom.domain.Porosity.Type          Constant
pfset Geom.domain.Porosity.Value         0.01

#-----------------------------------------------------------------------------
# Mannings coefficient
#-----------------------------------------------------------------------------
pfset Mannings.Type                                   "Constant"
pfset Mannings.GeomNames                              "domain"
pfset Mannings.Geom.domain.Value                      5.52e-6

#-----------------------------------------------------------------------------
# Contaminants
#-----------------------------------------------------------------------------
pfset Contaminants.Names                  ""

#-----------------------------------------------------------------------------
# Gravity
#-----------------------------------------------------------------------------
pfset Gravity                             1.0


#-----------------------------------------------------------------------------
# Domain
#-----------------------------------------------------------------------------
pfset Domain.GeomName                     "domain"

#----------------------------------------------------------------------------
# Mobility
#----------------------------------------------------------------------------
pfset Phase.water.Mobility.Type        Constant
pfset Phase.water.Mobility.Value       1.0

#-----------------------------------------------------------------------------
# Wells
#-----------------------------------------------------------------------------
pfset Wells.Names                         ""


#-----------------------------------------------------------------------------
# Timing (time units is set by units of permeability)
#-----------------------------------------------------------------------------
pfset TimingInfo.BaseUnit                 1.0
pfset TimingInfo.StartCount               0.0
pfset TimingInfo.StartTime                0.0
pfset TimingInfo.StopTime                 20.0
pfset TimingInfo.DumpInterval             -1
pfset TimeStep.Type                       Constant
pfset TimeStep.Value                      1.0

#-----------------------------------------------------------------------------
# Time Cycles
#-----------------------------------------------------------------------------
pfset Cycle.Names "constant rainrec"

# Constant
pfset Cycle.constant.Names              "alltime"
pfset Cycle.constant.alltime.Length      1
pfset Cycle.constant.Repeat             -1

pfset Cycle.rainrec.Names                 "rain rec"
pfset Cycle.rainrec.rain.Length           5
pfset Cycle.rainrec.rec.Length            20
pfset Cycle.rainrec.Repeat                -1


#-----------------------------------------------------------------------------
# Boundary Conditions
#-----------------------------------------------------------------------------
pfset BCPressure.PatchNames                   [pfget Geom.domain.Patches]

pfset Patch.x-lower.BCPressure.Type		      FluxConst
pfset Patch.x-lower.BCPressure.Cycle		      "constant"
pfset Patch.x-lower.BCPressure.alltime.Value	      0.0

pfset Patch.y-lower.BCPressure.Type		      FluxConst
pfset Patch.y-lower.BCPressure.Cycle		      "constant"
pfset Patch.y-lower.BCPressure.alltime.Value	      0.0

pfset Patch.z-lower.BCPressure.Type		      FluxConst
pfset Patch.z-lower.BCPressure.Cycle		      "constant"
pfset Patch.z-lower.BCPressure.alltime.Value	      0.0

pfset Patch.x-upper.BCPressure.Type		      FluxConst
pfset Patch.x-upper.BCPressure.Cycle		      "constant"
pfset Patch.x-upper.BCPressure.alltime.Value	      0.0

pfset Patch.y-upper.BCPressure.Type		      FluxConst
pfset Patch.y-upper.BCPressure.Cycle		      "constant"
pfset Patch.y-upper.BCPressure.alltime.Value	      0.0

pfset Patch.z-upper.BCPressure.Type		      OverlandFlow
pfset Patch.z-upper.BCPressure.Cycle		      "constant"
pfset Patch.z-upper.BCPressure.alltime.Value	      0.0

pfset Patch.z-upper.BCPressure.Type		      OverlandFlow
pfset Patch.z-upper.BCPressure.Cycle		      "rainrec"
pfset Patch.z-upper.BCPressure.rain.Value	      -0.005
pfset Patch.z-upper.BCPressure.rec.Value	      0.00000

#-----------------------------------------------------------------------------
# Topo slopes in x-direction
#-----------------------------------------------------------------------------
pfset TopoSlopesX.Type                                "PFBFile"
pfset TopoSlopesX.GeomNames                           "domain"
pfset TopoSlopesX.FileName                            "../parflow_input/LW.slopex.pfb"

#-----------------------------------------------------------------------------
# Topo slopes in y-direction
#-----------------------------------------------------------------------------
pfset TopoSlopesY.Type                                "PFBFile"
pfset TopoSlopesY.GeomNames                           "domain"
pfset TopoSlopesY.FileName                            "../parflow_input/LW.slopey.pfb"

#-----------------------------------------------------------------------------
# Phase sources:
#-----------------------------------------------------------------------------
pfset PhaseSources.water.Type                         "Constant"
pfset PhaseSources.water.GeomNames                    "domain"
pfset PhaseSources.water.Geom.domain.Value            0.0

#---------------------------------------------------------
# Initial conditions: water pressure
#---------------------------------------------------------
pfset ICPressure.Type                                   HydroStaticPatch
pfset ICPressure.GeomNames                              domain
pfset Geom.domain.ICPressure.Value                      1.005

pfset ICPressure.GeomNames                              "domain"
pfset Geom.domain.ICPressure.RefGeom                    domain
pfset Geom.domain.ICPressure.RefPatch                   z-lower


#-----------------------------------------------------------------------------
# Exact solution specification for error calculations
#-----------------------------------------------------------------------------
pfset KnownSolution                                   NoKnownSolution

#-----------------------------------------------------------------------------
# Set solver parameters
#-----------------------------------------------------------------------------
# ParFlow Solution
pfset Solver                                          Richards
pfset Solver.TerrainFollowingGrid                     True
pfset Solver.Nonlinear.VariableDz                     False

pfset Solver.MaxIter                                  25000
pfset Solver.Drop                                     1E-20
pfset Solver.AbsTol                                   1E-8
pfset Solver.MaxConvergenceFailures                   8

pfset Solver.Nonlinear.MaxIter                        80
pfset Solver.Nonlinear.ResidualTol                    1e-6
pfset Solver.Nonlinear.EtaChoice                      EtaConstant
pfset Solver.Nonlinear.EtaValue                       0.001
pfset Solver.Nonlinear.UseJacobian                    True
pfset Solver.Nonlinear.DerivativeEpsilon              1e-16
pfset Solver.Nonlinear.StepTol				 		  1e-30
pfset Solver.Nonlinear.Globalization                  LineSearch

pfset Solver.Linear.KrylovDimension                   70
pfset Solver.Linear.MaxRestarts                       2
pfset Solver.Linear.Preconditioner                    PFMG
pfset Solver.Linear.Preconditioner.PCMatrixType       FullJacobian

pfset Solver.PrintMannings                                True
pfset Solver.PrintPressure                            True
pfset Solver.PrintSaturation                          True
pfset Solver.PrintMask                                True
pfset Solver.WriteSiloSubsurfData 					  True
pfset Solver.WriteSiloPressure 						  True
pfset Solver.WriteSiloSaturation 					  True
pfset Solver.WriteSiloSlopes      					  True

#-----------------------------------------------------------------------------
# Distribute inputs
#-----------------------------------------------------------------------------
pfset ComputationalGrid.NX                41
pfset ComputationalGrid.NY                41
pfset ComputationalGrid.NZ                1
pfdist ../parflow_input/LW.slopex.pfb
pfdist ../parflow_input/LW.slopey.pfb

pfset ComputationalGrid.NZ                50


#-----------------------------------------------------------------------------
# Run Simulation
#-----------------------------------------------------------------------------
puts $runname
pfrun    $runname

#-----------------------------------------------------------------------------
# Undistribute outputs
#-----------------------------------------------------------------------------
pfundist $runname
pfundist ../parflow_input/LW.slopex.pfb
pfundist ../parflow_input/LW.slopey.pfb


puts "ParFlow run Complete"
