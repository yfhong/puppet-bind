# Define: bind::key
#
define bind::key (
  ) {
  require bind

  Class['::bind::package'] ->
  File["${keydir}/${key_name}"] ~>
  Class['::bind::service']
}
