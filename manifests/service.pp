# Class: bind::service
#
class bind::service inherits bind {
  require bind::package

  service { 'bind':
    name      => $::bind::service_name,
    enable    => true,
    ensure    => running,
  }
}
