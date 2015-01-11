# Define: bind::zone
#
define bind::zone (
  $zone_type,
  $domain,
  $allow_updates   = '',
  $allow_transfers = '',
  $ns_notify       = false,
  $also_notify     = '',
  $allow_notify    = '',
  $source          = '',
  ) {
  file { "${bind::confdir}/zones/${domain}.conf":
    ensure  => present,
    owner   => 'root',
    group   => $bind::params::bind_group,
    mode    => '0644',
    content => template('bind/zone.conf.erb'),
    notify  => Class['::bind::service'],
    require => Class['::bind::config'],
  }
}
