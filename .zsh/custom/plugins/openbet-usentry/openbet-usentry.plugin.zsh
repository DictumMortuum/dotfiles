@sync_cfg() {
  rsync -avz ~/Code/us-entry-cfg ops-cust:/opt/openbet/users/draviolo/
  rsync -avz ~/Code/us-entry-cfg ops-sports:/opt/openbet/users/draviolo/
  rsync -avz ~/Code/us-entry-cfg regression-cust:/opt/openbet/users/draviolo/
  rsync -avz ~/Code/us-entry-cfg regression-sports:/opt/openbet/users/draviolo/
}

@logs() {
  case $1 in
    oxi*)
      CMD="obcontrol --app=oxixmlserver_sports --tail"
    ;;
    xsys*)
      CMD='tail -f /opt/openbet/logs/xsys_sync_queue-sports/xsys_sync_queue_reconcile-sports.log.$(date +%F_%H)'
  esac

  ssh sports2 "$CMD"
}

alias pipeline=~/Code/us-entry-current-branches/pipeline
