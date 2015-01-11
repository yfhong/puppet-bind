# Class: bind::package
#
class bind::package inherits bind {
  package{ 'bind':
    name   => $::bind::package_name,
    ensure => $::bind::package_ensure,
  }
}
