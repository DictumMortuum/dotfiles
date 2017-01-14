# openbet

package provide work 1.0

namespace eval work {

  global DB

  proc init_db {conn server database args} {
  	global DB

  	eval {ob_db_multi::init $conn $server $database} $args

  	set DB $ob_db_multi::CONN($conn)
  }

  proc store_qry {name qry {cache 0} {conn_name SOURCE}} {
  	ob_db_multi::store_qry $conn_name $name $qry $cache
  }

  proc exec_qry {name {conn_name SOURCE} args} {
  	return [eval {ob_db_multi::exec_qry $conn_name $name} $args]
  }

  proc unprep_qry {name {conn_name SOURCE} args} {
  	ob_db_multi::unprep_qry $conn_name $name
  }

  proc rs_close {rs {conn_name SOURCE}}  {
  	ob_db_multi::rs_close $conn_name $rs
  }

  load libOT_Tcl.so
  load libOT_InfTcl.so

  OT_CfgRead $::env(HOME)/current/conf/env/env_local.cfg

  foreach {cfg default} {
    ENV_SHARED_TCL_DIR $::env(HOME)/current/shared_tcl
    SHARED_TCL         $::env(HOME)/current/shared_tcl
    DB_STORE_ACTIVE_SESS 0
    DB_STORE_SESS_INFO   0
  } {
    OT_CfgSet $cfg $default
  }

  set xtn [OT_CfgGet TCL_XTN tbc]
  lappend ::auto_path $::env(HOME)/current/shared_tcl

  package require util_log 4.5
  package require bin_standalone
  package require util_db_multi 4.5
  package require util_xl 4.5

  ob_log::sl_init "/tmp" "<<stdout>>"
  ob_xl::init

  init_db SOURCE [OT_CfgGet DB_SERVER] [OT_CfgGet DB_DATABASE]
}
