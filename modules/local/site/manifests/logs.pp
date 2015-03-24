class site::logs {

  tp::install { 'logrotate': }
  tp::install { 'rsyslog': }

}
