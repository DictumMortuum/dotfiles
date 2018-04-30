@sync_cfg() {
  rsync -avz ~/Code/us-entry-cfg ops-cust:/opt/openbet/users/draviolo/
  rsync -avz ~/Code/us-entry-cfg ops-sports:/opt/openbet/users/draviolo/
  rsync -avz ~/Code/us-entry-cfg regression-cust:/opt/openbet/users/draviolo/
  rsync -avz ~/Code/us-entry-cfg regression-sports:/opt/openbet/users/draviolo/
}
