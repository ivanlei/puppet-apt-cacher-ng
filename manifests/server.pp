# == Class: apt_cacher_ng::server
# Configures a machine to be an apt-cacher-ng server for APT updates
#
# === Parameters
#
# [version] Version of the apt-cacher-ng to install.  Optional. Default: 'latest'
#
# === Examples
# class { 'apt_cacher_ng::server':
# }
#
class apt_cacher_ng::server(
  $version = 'installed'
) {
  package { 'apt-cacher-ng':
    ensure => $version,
  }

  service { 'apt-cacher-ng':
    ensure  => running,
    require => Package['apt-cacher-ng'],
  }

  file { '/etc/apt-cacher-ng/acng.conf':
    source  => ["puppet:///modules/site-apt_cacher_ng/${::fqdn}/acng.conf",
      'puppet:///modules/site-apt_cacher_ng/acng.conf',
      'puppet:///modules/apt_cacher_ng/acng.conf'],
    notify  => Service['apt-cacher-ng'],
    require => Package['apt-cacher-ng'],
  }

  file { '/var/cache/apt-cacher-ng':
    ensure  => directory,
    owner   => 'apt-cacher-ng',
    require => Package['apt-cacher-ng'],
  }
}
