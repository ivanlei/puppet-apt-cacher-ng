class apt-cacher-ng::autoupdate_client(
  $server = "",
  $servers = "",
  $autodetect = true,
  $verbose = true
) {

  class { 'apt-cacher-ng::client':
    server      => $server,
    servers     => $servers,
    autodetect  => $autodetect,
    verbose     => $verbose,
    before      => [Class['apt']]
  }

  class { 'apt':
    always_apt_update => true
  }
}