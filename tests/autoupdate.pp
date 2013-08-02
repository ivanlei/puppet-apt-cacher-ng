class { 'apt-cacher-ng::autoupdate_client':
  server => "${aptserver_ip}:3142"
}
