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
export TCLEXTENSION=tcl
export TCLLIBPATH='/usr/lib/tcl8.5:/space/pmu/tcl8.5.7/lib/64:/space/pmu/tcl8.5.7/lib/ot_tibems0.2:/opt/tcl/lib:/opt/informix/lib:/opt/informix/lib/esql'
export TCLPRO=/opt/TclPro/linux-ix86/
export TCL_PRO=/opt/TclPro/linux-ix86/
export LD_LIBRARY_PATH='/usr/lib:/space/pmu/tibems/lib/64:/space/pmu/tibems/lib:/space/pmu/tcl8.5.7/lib:/opt/informix/lib:/opt/informix/lib/esql:/opt/informix/lib:/lib'

# Path
test -d "/bin" && PATH="/bin:$PATH"
test -d "/opt/apache-ant/bin" && PATH="/opt/apache-ant/bin:$PATH"
test -d "/opt/apache-maven/bin" && PATH="/opt/apache-maven/bin:$PATH"
test -d "/opt/informix/bin" && PATH="/opt/informix/bin:$PATH"
test -d "/opt/puppetlabs/bin" && PATH="/opt/puppetlabs/bin:$PATH"
test -d "/shared/orbis/Support/CustomerDB" && PATH="/shared/orbis/Support/CustomerDB:$PATH"
test -d "/shared/prj/openbet/appserv/rhel/6/x86_64/bin" && PATH="/shared/prj/openbet/appserv/rhel/6/x86_64/bin:$PATH"
test -d "/shared/prj/openbet/liveserv/rhel/6/x86_64/sbin" && PATH="/shared/prj/openbet/liveserv/rhel/6/x86_64/sbin:$PATH"
test -d "/usr/java/latest/bin" && PATH="/usr/java/latest/bin:$PATH"
test -d "/usr/lib64/qt-3.3/bin" && PATH="/usr/lib64/qt-3.3/bin:$PATH"

unset LS_COLORS
unset LSCOLORS

alias dbschema="dbschema-11.50 -d pmu_0"
