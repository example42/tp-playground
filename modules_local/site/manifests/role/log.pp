class site::role::log {

  tp::install { 'redis': }
  tp::install { 'logstash': }
  tp::install { 'elasticsearch': }

}
