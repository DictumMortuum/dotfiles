docker_containers () {
  return $(sudo docker ps -a | awk '{print $1}' | grep -v CONTAINER)
}

docker_op () {
  CONTAINERS=docker_containers
  NOCONTAINERS=$(echo $CONTAINERS | wc -l)

  if [ $NCONTAINERS > 0 ]; then
    echo $CONTAINERS | xargs sudo docker $1
  else
    echo "No containers to $1"
  fi
}

docker_stop () {
  docker_op stop
}

docker_rm () {
  docker_op rm
}

docker_clean () {
  docker_op stop
  docker_op rm
}

docker_run () {
  sudo docker run -i -t --dns=10.197.0.20 -v /tmp/sb1/:/home/openbet/Projects/ -v ~/.ssh/:/home/openbet/.ssh $1 boot
}
