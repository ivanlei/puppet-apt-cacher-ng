class { 'apt-cacher-ng::client':
  server => "${aptserver_ip}:3142",
}
