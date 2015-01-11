# Class: bind::config
#
class bind::config (
  ) inherits bind {
  require bind::package

  # directory
  file { [ $confdir, $required_dirs ]:
    ensure  => directory,
    mode    => '0755',
    purge   => true,
    recurse => true,
  }

  # keep distribution packaged files
  file { $::bind::required_files:
    ensure => present,
  }

  file { "${confdir}/named.conf":
    content => template('bind/named.conf.erb'),
  }

  file { "${confdir}/named.conf.local":
    replace = false,
  }

  concat { $config_snippets:
    owner => $bind_user,
    group => $bind_group,
    mode  => '0644',
  }
}
