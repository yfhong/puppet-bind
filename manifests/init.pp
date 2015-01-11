# == Class: bind
#
# Full description of class bind here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'bind':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2015 Your name here, unless otherwise noted.
#
class bind (
  # params for bind package
  $package_name    = $::bind::params::package_name,
  $package_ensure  = $::bind::params::package_ensure,
  # params for bind service
  $service_name    = $::bind::params::service_name,
  $service_ensure  = $::bind::params::service_ensure,
  # params for bind config
  $confdir         = $::bind::params::confdir,
  $cachedir        = $::bind::params::cachedir,
  $listen_on_addr  = $::bind::params::listen_on_addr,
  $listen_on_ipv6  = $::bind::params::listen_on_ipv6,
  $listen_on_port  = $::bind::params::listen_on_port,
  ) inherit bind::params {

  require stdlib
  require concat

  class { '::bind::package': } ->
  class { '::bind::config': } ~>
  class { '::bind::service': }

  # $acls = hiera('bind::acls', {})
  # create_resources('::bind::acl', $acls)

  # $zones = hiera('bind::zones', {})
  # create_resources('::bind::zone', $zones)

  # $views = hiera('bind::views', {})
  # create_resources('::bind::view', $views)
}
