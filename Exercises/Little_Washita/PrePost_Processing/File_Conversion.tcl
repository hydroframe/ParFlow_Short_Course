
lappend   auto_path $env(PARFLOW_DIR)/bin
package   require parflow
namespace import Parflow::*

pfset     FileVersion    4

#Converting from pfb to sa
set   slopex  [pfload -pfb LW.slopex.pfb]
pfsave $slopex	-sa LW.slopex.sa

set   slopey  [pfload -pfb LW.slopey.pfb]
pfsave $slopey	-sa LW.slopey.sa

#Converting sa to pfb and silo
#set   slopex  [pfload -sa LW.slopex_mod.sa]
#pfsetgrid {41 41 1} {0.0 0.0 0.0} {1000.0 1000.0 2.0} $slopex
#pfsave $slopex -silo LW.slopex_mod.silo
#pfsave $slopex -pfb  LW.slopex_mod.pfb

#set   slopey  [pfload -sa LW.slopey_mod.sa]
#pfsetgrid {41 41 1} {0.0 0.0 0.0} {1000 1000 2} $slopey
#pfsave $slopey -silo LW.slopey_mod.silo
#pfsave $slopey -pfb  LW.slopey_mod.pfb
