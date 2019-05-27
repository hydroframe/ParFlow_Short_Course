#
# Import the ParFlow TCL package
#
lappend auto_path $env(PARFLOW_DIR)/bin 
package require parflow
namespace import Parflow::*

pfset FileVersion 4

set runname EastInlet

# Never manipulate the original files, a habit I like to get in to
file copy -force East_slopex_Sm.pfb slopex.pfb
file copy -force East_slopey_Sm.pfb slopey.pfb

set XslopeFile slopex.pfb
set YslopeFile slopey.pfb

set NP  [lindex $argv 0]
set NQ  [lindex $argv 1]

pfset Process.Topology.P        $NP
pfset Process.Topology.Q        $NQ
pfset Process.Topology.R        1

# Should be: 160, 134, 56
set nx 160
set ny 134
set nz 56

# Should be: 40, 40, 25
set dx 40
set dy $dx
set dz 25
                
# Should be: 437300, 4450260, 2910
set x0 437300
set y0 4450260
set z0 2910.0

set xmax [expr $x0 + ($nx * $dx)]
set ymax [expr $y0 + ($ny * $dy)]
set zmax [expr $z0 + ($nz * $dz)]
#
#---------------------------------------------------------
# Computational Grid
#---------------------------------------------------------
pfset ComputationalGrid.Lower.X                 $x0
pfset ComputationalGrid.Lower.Y                 $y0
pfset ComputationalGrid.Lower.Z                 $z0

pfset ComputationalGrid.DX	                 $dx
pfset ComputationalGrid.DY                       $dy
pfset ComputationalGrid.DZ	                 $dz

pfset ComputationalGrid.NX                      $nx
pfset ComputationalGrid.NY                      $ny
pfset ComputationalGrid.NZ                      $nz

#---------------------------------------------------------
# The Names of the GeomInputs
#---------------------------------------------------------

pfset GeomInput.Names                 "solidinput"

pfset GeomInput.solidinput.GeomNames   domain
pfset GeomInput.solidinput.InputType   SolidFile
pfset GeomInput.solidinput.FileName    TopesActiveDomain.pfsol
pfset Geom.domain.Patches              "BOTTOM TOP"

#-----------------------------------------------------------------------------
# Perm
#-----------------------------------------------------------------------------
pfset Geom.Perm.Names                 "domain"

pfset Geom.domain.Perm.Type            Constant
pfset Geom.domain.Perm.Value           0.01

if (1==0) {
pfset Geom.domain.Perm.Type "TurnBands"
pfset Geom.domain.Perm.LambdaX  160.
pfset Geom.domain.Perm.LambdaY  120.
pfset Geom.domain.Perm.LambdaZ  30
pfset Geom.domain.Perm.GeomMean  0.01
pfset Geom.domain.Perm.Sigma   0.5
pfset Geom.domain.Perm.NumLines 40
pfset Geom.domain.Perm.RZeta  5.0
pfset Geom.domain.Perm.KMax  100.0
pfset Geom.domain.Perm.DelK  0.2
pfset Geom.domain.Perm.Seed  23333
pfset Geom.domain.Perm.LogNormal Log
pfset Geom.domain.Perm.StratType Bottom
}


pfset Perm.TensorType               TensorByGeom

pfset Geom.Perm.TensorByGeom.Names  "domain"

pfset Geom.domain.Perm.TensorValX  1.0d0
pfset Geom.domain.Perm.TensorValY  1.0d0
pfset Geom.domain.Perm.TensorValZ  1.0d0

#-----------------------------------------------------------------------------
# Specific Storage
#-----------------------------------------------------------------------------

pfset SpecificStorage.Type            Constant
pfset SpecificStorage.GeomNames       "domain"
pfset Geom.domain.SpecificStorage.Value 1.0e-5

#-----------------------------------------------------------------------------
# Phases
#-----------------------------------------------------------------------------

pfset Phase.Names "water"

pfset Phase.water.Density.Type	        Constant
pfset Phase.water.Density.Value	        1.0
pfset Phase.water.Viscosity.Type	Constant
pfset Phase.water.Viscosity.Value	1.0

#-----------------------------------------------------------------------------
# Contaminants
#-----------------------------------------------------------------------------

pfset Contaminants.Names			""

#-----------------------------------------------------------------------------
# Retardation
#-----------------------------------------------------------------------------

pfset Geom.Retardation.GeomNames           ""

#-----------------------------------------------------------------------------
# Gravity
#-----------------------------------------------------------------------------

pfset Gravity				1.0

#-----------------------------------------------------------------------------
# Domain
#-----------------------------------------------------------------------------

pfset Domain.GeomName domain

#-----------------------------------------------------------------------------
# Porosity
#-----------------------------------------------------------------------------
pfset Geom.Porosity.GeomNames           "domain"

pfset Geom.domain.Porosity.Type         Constant
pfset Geom.domain.Porosity.Value        0.3

#-----------------------------------------------------------------------------
# Relative Permeability
#-----------------------------------------------------------------------------
pfset Phase.RelPerm.Type           VanGenuchten
pfset Phase.RelPerm.GeomNames      "domain"

pfset Geom.domain.RelPerm.Alpha    3.548
pfset Geom.domain.RelPerm.N        4.162 
pfset Geom.domain.RelPerm.NumSamplePoints   20000
pfset Geom.domain.RelPerm.MinPressureHead   -50000
pfset Geom.domain.RelPerm.InterpolationMethod   "Linear"

#-----------------------------------------------------------------------------
# Saturation
#-----------------------------------------------------------------------------
pfset Phase.Saturation.Type              VanGenuchten
pfset Phase.Saturation.GeomNames         "domain "

pfset Geom.domain.Saturation.Alpha        3.548
pfset Geom.domain.Saturation.N            4.162
pfset Geom.domain.Saturation.SRes         0.0001
pfset Geom.domain.Saturation.SSat         1.0

#---------------------------------------------------------
# Mannings coefficient 
#---------------------------------------------------------
pfset Mannings.Type "Constant"
pfset Mannings.GeomNames "domain"
pfset Mannings.Geom.domain.Value 0.01

#-----------------------------------------------------------------------------
# Wells
#-----------------------------------------------------------------------------
pfset Wells.Names                           ""

#-----------------------------------------------------------------------------
# Setup timing info
#----------------------------------------------------------------------------- 
# P minus E forcing is in hours, so all units are in hours
pfset TimingInfo.BaseUnit        0.1
pfset TimingInfo.StartCount      0
pfset TimingInfo.StartTime       0.0
pfset TimingInfo.StopTime        0.1
pfset TimingInfo.DumpInterval	 0.1
#pfset TimingInfo.DumpInterval    -1
pfset TimeStep.Type              Constant
pfset TimeStep.Value             0.1

#-----------------------------------------------------------------------------
# Time Cycles
#-----------------------------------------------------------------------------
pfset Cycle.Names "constant"
pfset Cycle.constant.Names              "alltime"
pfset Cycle.constant.alltime.Length      1
pfset Cycle.constant.Repeat             -1
 
#-----------------------------------------------------------------------------
# Boundary Conditions: Pressure
#-----------------------------------------------------------------------------
pfset BCPressure.PatchNames                   "BOTTOM TOP"

pfset Patch.BOTTOM.BCPressure.Type		      FluxConst
pfset Patch.BOTTOM.BCPressure.Cycle		      "constant"
pfset Patch.BOTTOM.BCPressure.alltime.Value	      0.0

pfset Patch.TOP.BCPressure.Type		              OverlandFlow
pfset Patch.TOP.BCPressure.Cycle		      "constant"
pfset Patch.TOP.BCPressure.alltime.Value	      -0.00079

##---------------------------------------------------------
## Topo slopes from PFBs
##---------------------------------------------------------
pfset ComputationalGrid.NZ                      1
pfset TopoSlopesX.Type "PFBFile"
pfset TopoSlopesX.GeomNames "domain"
pfset TopoSlopesX.FileName  $XslopeFile

pfset TopoSlopesY.Type "PFBFile"
pfset TopoSlopesY.GeomNames "domain"
pfset TopoSlopesY.FileName  $YslopeFile

pfdist $XslopeFile
pfdist $YslopeFile

pfset ComputationalGrid.NZ                      $nz

if (1==0) {
# Override block for slopes
pfset TopoSlopesX.Type "Constant"
pfset TopoSlopesX.GeomNames "domain"
pfset TopoSlopesX.Geom.domain.Value 0.0
pfset TopoSlopesY.Type "Constant"
pfset TopoSlopesY.GeomNames "domain"
pfset TopoSlopesY.Geom.domain.Value 0.0
}
#-----------------------------------------------------------------------------
# Phase sources:
#-----------------------------------------------------------------------------

pfset PhaseSources.water.Type                         Constant
pfset PhaseSources.water.GeomNames                    domain
pfset PhaseSources.water.Geom.domain.Value        0.0

#-----------------------------------------------------------------------------
# Exact solution specification for error calculations
#-----------------------------------------------------------------------------

pfset KnownSolution                                    NoKnownSolution

#-----------------------------------------------------------------------------
# Set solver parameters
#-----------------------------------------------------------------------------

pfset Solver                                             Richards
pfset Solver.MaxIter                                     250000

pfset Solver.Nonlinear.MaxIter                           100
pfset Solver.Nonlinear.ResidualTol                       1e-8
pfset Solver.Nonlinear.EtaChoice                         Walker1
pfset Solver.Nonlinear.UseJacobian                       True
pfset Solver.Nonlinear.DerivativeEpsilon                 1e-14
pfset Solver.Nonlinear.StepTol							 1e-15
pfset Solver.Nonlinear.Globalization                     LineSearch
pfset Solver.Linear.KrylovDimension                      50
pfset Solver.Linear.MaxRestart                           5
pfset Solver.MaxConvergenceFailures                      5

pfset Solver.Linear.Preconditioner                      PFMG
pfset Solver.Linear.Preconditioner.PCMatrixType 	    FullJacobian
pfset Solver.Nonlinear.PrintFlag	    		        LowVerbosity

pfset Solver.PrintSubsurf								False
pfset Solver.Drop                                       1E-15
pfset Solver.AbsTol                                     1E-8
 
pfset Solver.WriteSiloSubsurfData           False
pfset Solver.WriteSiloPressure              True
pfset Solver.WriteSiloSaturation            False
pfset Solver.WriteSiloSlopes                False
pfset Solver.WriteSiloMask 					True

#---------------------------------------------------------
# Initial conditions: water pressure
#---------------------------------------------------------

#
pfset ICPressure.Type                                   HydroStaticPatch
pfset ICPressure.GeomNames                              domain
pfset Geom.domain.ICPressure.Value                      -30.0
pfset Geom.domain.ICPressure.RefGeom                    domain
pfset Geom.domain.ICPressure.RefPatch                   TOP
 
#-----------------------------------------------------------------------------
# Distribute the remaining input files and write the ParFlow database
#-----------------------------------------------------------------------------

pfrun $runname

set perm_infile [format "%s.out.perm_x.pfb" $runname]
set Perm [pfload -pfb $perm_infile]
pfvtksave $Perm -vtk [format "%s.out.perm_x.vtk" $runname] -var "Perm" -flt
