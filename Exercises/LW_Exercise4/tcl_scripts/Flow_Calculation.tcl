#-----------------------------------------------------------------------------
#Calculate Flow using Mannings equation on USGS stations
## units = m3/s
#-----------------------------------------------------------------------------

# Import the ParFlow TCL package
lappend   auto_path $env(PARFLOW_DIR)/bin
package   require parflow
namespace import Parflow::*

pfset     FileVersion    4

pfset Process.Topology.P 1
pfset Process.Topology.Q 1
pfset Process.Topology.R 1

#-----------------------------------------------------------------------------
# Computational Grid
#-----------------------------------------------------------------------------
pfset ComputationalGrid.Lower.X           0.0
pfset ComputationalGrid.Lower.Y           0.0
pfset ComputationalGrid.Lower.Z           0.0

pfset ComputationalGrid.NX                41
pfset ComputationalGrid.NY                41
pfset ComputationalGrid.NZ                50

pfset ComputationalGrid.DX                1000.0
pfset ComputationalGrid.DY                1000.0
pfset ComputationalGrid.DZ                2.0

set dx                                    1000.0
set dy                                    1000.0
set dz                                    2.0

#-----------------------------------------------------------------------------
# Runname Directory and timing
#-----------------------------------------------------------------------------
set timesteps     24
set runname        "LW"
cd "../run_dir"

#pfset  ComputationalGrid.NZ   1
set sx   [pfload LW.slopex.pfb]
set sy   [pfload LW.slopey.pfb]
#pfset  ComputationalGrid.NZ   50

set mask [pfload $runname.out.mask.pfb]
set top [pfcomputetop $mask]


set output [open flow_out.txt w ]
puts $output "Time\t  Pressure(m)\t  Flow(cms)\t"


set Xloca 40
set Yloca 31 

#Get the slope at the desired location
set sx1 [pfgetelt $sx $Xloca $Yloca 0]
set sy1 [pfgetelt $sy $Xloca $Yloca 0]
set S [expr ($sx1**2+$sy1**2)**0.5]

puts stdout "Slope at $Xloca $Yloca = $S"

for {set ii 0} {$ii <=$timesteps } {incr ii} {

    #Read in the pressure ans saturation and get the data for the point of interest
    set press [pfload [format $runname.out.press.%05d.pfb $ii]]
    puts $runname.out.press.$ii.pfb
    set P [pfgetelt $press $Xloca $Yloca 49]
    set satin [format $runname.out.satur.%05d.pfb $ii]
    puts $satin
    set satur [pfload $satin]

    #Clean up 
    pfdelete $press
    unset press
    pfdelete $satur
    unset satur

    #Calculat the flow
    if {$P >= 0} {
      puts stdout "Top Pressure = $P at time $ii"
    }  else {
       set P 0
    }
    set QT [expr ($dx/5.52e-6)*($S**0.5)*($P**(5./3.))/3600]
    puts $output "$ii\t $P\t $QT\t"

}

close $output




