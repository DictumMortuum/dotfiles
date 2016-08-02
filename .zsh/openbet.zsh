# Informix
export DB_SERVER="db01_1150"
export DB_DATABASE="pmu_01"
export INFORMIXDIR="/opt/informix"
export INFORMIXSERVER="db01_1150"
alias dbaccess="rlwrap dbaccess"

# Build
export JAVA_HOME=/usr/lib/jvm/java-1.6.0-sun-1.6.0.45.x86_64
export _JAVA_OPTIONS="-Xmx512m"
export DEPLOYMENT=/shared/prj/deployment/v4latest-64/
export APPSERVDIR=/opt/appserv/CURRENT
ulimit -v 4194304

# TCL
export TCL=/opt/tcl8.5
export TCL=/opt/tcl8.5
export TCLEXTENSION=tcl
export TCLLIBPATH='/usr/lib/tcl8.5:/space/pmu/tcl8.5.7/lib/64:/space/pmu/tcl8.5.7/lib/ot_tibems0.2:/opt/tcl/lib:/opt/informix/lib:/opt/informix/lib/esql'
export TCLPRO=/opt/TclPro/linux-ix86/
export TCL_PRO=/opt/TclPro/linux-ix86/
export LD_LIBRARY_PATH='/usr/lib:/space/pmu/tibems/lib/64:/space/pmu/tibems/lib:/space/pmu/tcl8.5.7/lib:/opt/informix/lib:/opt/informix/lib/esql:/opt/informix/lib:/lib'

# Path
PATH="$PATH:/opt/TclDevKit/bin:/opt/apache-ant/bin:/opt/apache-maven/bin:/opt/informix/bin:/opt/puppetlabs/bin:/shared/orbis/Support/CustomerDB:/shared/prj/openbet/appserv/rhel/6/x86_64/bin:/shared/prj/openbet/liveserv/rhel/6/x86_64/sbin:/usr/java/latest/bin:/usr/lib64/qt-3.3/bin"
