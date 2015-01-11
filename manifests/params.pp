# Class: bind::params
#
class bind::params (
  $package_name,
  $package_ensure = 'latest',  # [present, absent, latest]
  $service_name,
  $service_ensure = 'running',   # [running, stopped]
  $bind_user = 'bind',
  $bind_group = 'bind',
  $bind_rndc = true,
  $confdir,
  $cachedir,
  $required_dirs,
  $required_files,
  $config_snippets,
  ) {
  $config_snippets = [
                      "${confdir}/named.conf.acls",
                      "${confdir}/named.conf.keys",
                      ]
  ## os specified params
  case $::operatingsystem {
    default: { fail("unsupported os ${::operatingsystem}, version ${::operatingsystemrelease}") }
    /(?i:RedHat|CentOS)/: {
      if (
        ($::operatingsystemmajversion == '5'
        and versioncmp($::operatingsystemrelease, '5.8') >= 0)
        or ($::operatingsystemmajversion == '6'
        and versioncmp($::operatingsystemrelease, '6.4') >= 0)
        or ($::operatingsystemmajversion == '7'
        and versioncmp($::operatingsystemrelease, '7.0') >= 0)
        ) {
        $package_name = 'bind'
        $service_name = 'named'
        $bind_user    = 'root'
        }
    } # end of redhat/centos linux
    /(?i:Debian)/: {
      if (versioncmp($::operatingsystemrelease, '6.0') >= 0) {
        $package_name = 'bind9'
        $service_name = 'bind9'
        $confdir      = '/etc/bind'
        $cachedir     = '/var/cache/bind'
        $required_dirs = [
                          "${confdir}/master",
                          "${confdir}/slave",
                          "${confdir}/dynamic",
                          ]
        $required_files = [
                           "${confdir}/bind.keys",
                           "${confdir}/db.empty",
                           "${confdir}/db.local",
                           "${confdir}/db.root",
                           "${confdir}/db.0",
                           "${confdir}/db.127",
                           "${confdir}/db.255",
                           "${confdir}/named.conf.default-zones",
                           "${confdir}/rndc.key",
                           "${confdir}/zones.rfc1918",
                           ]
      }
    } # end of debian linux
    /(?i:Ubuntu)/: {
      if (
        versioncmp($::operatingsystemrelease, '12.04') >= 0
        ) {
        $package_name = 'bind9'
        $service_name = 'bind9'
        $confdir      = '/etc/bind'
        $cachedir     = '/var/cache/bind'
        $required_dirs = [
                          "${confdir}/master",
                          "${confdir}/slave",
                          "${confdir}/dynamic",
                          ]
        $required_files = [
                           "${confdir}/bind.keys",
                           "${confdir}/db.empty",
                           "${confdir}/db.local",
                           "${confdir}/db.root",
                           "${confdir}/db.0",
                           "${confdir}/db.127",
                           "${confdir}/db.255",
                           "${confdir}/named.conf.default-zones",
                           "${confdir}/rndc.key",
                           "${confdir}/zones.rfc1918",
                           ]
        }
    } # end of ubuntu linux
    /(?i:FreeBSD)/: {
      if (
        versioncmp($::operatingsystemrelease, '8.0') >= 0
        ) {
        $package_name = 'bind910'
        $service_name = 'named'
        $confdir      = '/usr/local/etc/namedb'
        $cachedir     = "${confdir}/working"
        $required_dirs = [
                          "${confdir}/master",
                          "${confdir}/slave",
                          "${confdir}/dynamic",
                          "${confdir}/working"
                          ]
        $required_files = [
                           "${confdir}/bind.keys",
                           "${confdir}/master/empty.db",
                           "${confdir}/master/localhost-forward.db",
                           "${confdir}/master/localhost-reverse.db",
                           "${confdir}/rndc.key",
                           ]
        }
    } # end of freebsd
    /(?i:Amazon)/: {
      if (
        versioncmp($::operatingsystemrelease, '6.0') >= 0
        ) {
        $package_name = 'bind'
        $service_name = 'named'
        $bind_user    = 'root'
        }
    } # end of amazon linux
  } # end of case statement
}  # end of class bind::params
