require docker && return 1

__docker_containers () {
  return $(sudo docker ps -a | awk '{print $1}' | grep -v CONTAINER)
}

__docker_op () {
  CONTAINERS=__docker_containers
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

__docker_rm () {
  __docker_op rm
}

docker_clean () {
  docker_op stop
  docker_op rm
}

docker_run () {
  sudo docker run -i -t --dns=10.197.0.20 -v /tmp/volume -v ~/.ssh/:/home/user/.ssh $1 boot
}
