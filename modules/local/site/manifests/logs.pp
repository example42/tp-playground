class site::logs {

  tp::install { 'logrotate': }
  # tp::install { 'rsyslog': }
  
  # Test separate data module
  # tp::install { 'rsyslog': data_module => 'tinydata' }

}
