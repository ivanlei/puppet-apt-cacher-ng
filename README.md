# ivanlei-apt_cacher_ng

A Puppet module for [apt-cacher-ng], with examples in a `Vagrantfile` for quick deployment on [Vagrant].

Original author: [Alban Peignier], Forked From: [Garth Kidd]

## Installation in Production

* Edit the definition for your server to include `apt_cacher_ng::server`, perhaps
  specifying `version`:
  ```ruby      
  class { 'apt_cacher_ng::s`ƒerver':
    # version => '0.4.6-1ubuntu1',
  }
  ```
  The server will be available at the default port (3142).
  The server will not use itself as a cache by default. 

* Edit the definition for your clients to include `apt_cacher_ng::client`:
  ```ruby
  class { 'apt_cacher_ng::client':
    servers  => ['192.168.31.42:3142'],
  }
  ```

* To force the client to run `apt-get update` before other puppet actions, use the `apt_cacher_ng::autoupdate_client`:
  ```ruby
  class { 'apt_cacher_ng::autoupdate_client':
    servers => ['192.168.31.42:3142']
  }
  ```

* To specify more than one server:
  ```ruby
  class { 'apt_cacher_ng::client':
    servers => ['192.168.30.42:3142', '192.168.31.42:3142'],
  }
  ```

* To disable fallback to direct access if the proxy is not available:
  ```ruby
  class { 'apt_cacher_ng::client':
    autodetect => false,
    servers    => ['192.168.31.42:3142'],
  }
  ```
  Per [askubuntu:54099], you'll need to do this on older Ubuntu and Debian
  releases. Lucid and Squeeze support `Acquire::http::ProxyAutoDetect`;
  Karmic and Lenny don't.

## Testing

To smoke test the module:

    make test

To test the module properly, install [Vagrant] and:

    make vm

[apt-cacher-ng]: http://www.unix-ag.uni-kl.de/~bloch/acng/
[smoke test]: http://docs.puppetlabs.com/guides/tests_smoke.htm
[Alban Peignier]: https://github.com/albanpeignier
[Garth Kidd]: https://github.com/garthk
[Gabriel Filion]: https://github.com/lelutin
[Lekensteyn]: http://www.lekensteyn.nl/
[Vagrant]: http://vagrantup.com/
[host-only networking]: http://vagrantup.com/docs/host_only_networking.html
[askubuntu:54099]: http://askubuntu.com/a/54099
[Puppet Provisioning]: http://vagrantup.com/docs/provisioners/puppet.html
