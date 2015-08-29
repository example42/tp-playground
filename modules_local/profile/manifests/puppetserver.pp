# == Class: profile::puppetserver
#
class profile::puppetserver (
  $ensure                     = 'present',

  $config_dir_source          = undef,
  $config_file_template       = undef,

) {

  $options_default = {
    server => 'puppet',
  }
  $options_user=hiera_hash('puppet_options', {} )
  $options=merge($options_default,$options_user)

  if $ensure == 'absent' {
    ::tp::uninstall { 'puppetserver': }
  } else {
    include ::java
    ## Exec['tp_apt_update'] -> Class['java']
    ::tp::install { 'puppetserver': }
  }

  ::tp::dir { 'puppetserver':
    ensure => $ensure,
    source => $config_dir_source,
  }
  ::tp::conf { 'puppetserver':
    ensure       => $ensure,
    template     => $config_file_template,
    options_hash => $options,
  }

}
