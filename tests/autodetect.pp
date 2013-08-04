class { 'apt_cacher_ng::client':
  # Only one of these servers should be found
  servers    => ["${aptserver_ip}:3142", "${bad_aptserver_ip}:3142"],
  verbose    => false,
  autodetect => true,
}
