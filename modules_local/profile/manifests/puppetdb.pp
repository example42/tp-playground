# == Class: profile::puppetdb
#
class profile::puppetdb (
  $ensure                     = 'present',

  $config_dir_source          = undef,
  $config_file_template       = 'profile/puppetdb/puppetdb.conf.erb',

) {

  $options_default = {
    server => 'puppet',
  }
  $options_user=hiera_hash('puppet_options', {} )
  $options=merge($options_default,$options_user)

  if $ensure == 'absent' {
    ::tp::uninstall { 'puppetdb': }
  } else {
    include ::java
    Exec['tp_apt_update'] -> Class['java']
    ::tp::install { 'puppetdb': }
  }

  ::tp::dir { 'puppetdb':
    ensure => $ensure,
    source => $config_dir_source,
  }
  ::tp::conf { 'puppetdb':
    ensure       => $ensure,
    #    template     => $config_file_template,
    options_hash => $options,
  }

}