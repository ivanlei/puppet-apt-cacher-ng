class apt_cacher_ng::server(
  $version = 'installed'
) {
  package { 'apt_cacher_ng':
    ensure => $version,
  }

  service { 'apt_cacher_ng':
    ensure  => running,
    require => Package['apt_cacher_ng'],
  }

  file { '/etc/apt_cacher_ng/acng.conf':
    source  => ["puppet:///modules/site-apt_cacher_ng/${::fqdn}/acng.conf",
      'puppet:///modules/site-apt_cacher_ng/acng.conf',
      'puppet:///modules/apt_cacher_ng/acng.conf'],
    notify  => Service['apt_cacher_ng'],
    require => Package['apt_cacher_ng'],
  }

  file { '/var/cache/apt_cacher_ng':
    ensure  => directory,
    owner   => 'apt_cacher_ng',
    require => Package['apt_cacher_ng'],
  }
}
