# == Class: apt_cacher_ng::client
# Configures a machine to use an apt-cacher-ng server for APT updates
#
# === Parameters
#
# [servers] An array of servers in the format ip:port or hostname:port.  Required.
# [autodetect] Fallback to direct access if proxy is unavailable.  Optional.  Default true.
# [verbose] Whether to have APT print server status.  Optional.  Default true.
# [apt_update] Whether to apt-get update during provisioning.  Optional.  Default false.
#
# === Examples
# class { 'apt_cacher_ng::client':
#   servers    => ['192.168.10.11:3142']
#   apt_update => true,
# }
#
class apt_cacher_ng::client(
  $servers    = undef,
  $autodetect = false,
  $verbose    = true,
  $apt_update = false,
) {
  validate_array($servers)
  validate_bool($autodetect, $verbose, $apt_update)

  # Swap into numeric
  $show_proxy_messages = bool2num($verbose)

  # Set some defaults for files created by this class
  File {
    owner  => root,
    group  => root,
    mode   => '0644',
    ensure => present,
  }

  if $autodetect == false {
    file { '/etc/apt/apt.conf.d/71proxy':
      content => template('apt_cacher_ng/71proxy.erb'),
    }

    file { '/etc/apt/apt.conf.d/30detectproxy':
      ensure => absent,
    }

  } else {
    file { '/etc/apt/apt.conf.d/71proxy':
      ensure => absent,
    }

    file { '/etc/apt/apt.conf.d/30detectproxy':
      source => 'puppet:///modules/apt_cacher_ng/30detectproxy',
    }

    file { '/etc/apt/detect-http-proxy':
      source => 'puppet:///modules/apt_cacher_ng/detect-http-proxy',
      mode   => '0755',
    }

    file { '/etc/apt/proxy.conf':
      content => template('apt_cacher_ng/apt-proxy-conf.erb'),
    }
  }

  if $apt_update {
    class { 'apt':
      always_apt_update => true
    }
  }
}
