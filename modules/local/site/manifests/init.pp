class site (
  $repo_class        = '::site::repo',
  $puppet_class      = '::site::puppet',
  $tools_class       = '::site::tools',
  $network_class     = '::site::network',
  $users_class       = '::site::users',
  $sysctl_class      = '::site::sysctl',
  $time_class        = '::site::time',
  $mail_class        = '::site::mail::postfix',
  $access_class      = '::site::access',
  $monitor_class     = '::site::monitor',
  $firewall_class    = '::site::firewall',
  $backup_class      = '::site::backup::duply',
  $logs_class        = '::site::logs',
  $hardening_class   = '::site::hardening',
  ) {

  if $repo_class and $repo_class != '' {
    include $repo_class
  }

  if $puppet_class and $puppet_class != '' {
    include $puppet_class
  }

  if $network_class and $network_class != '' {
    include $network_class
  }

  if $tools_class and $tools_class != '' {
    include $tools_class
  }

  if $sysctl_class and $sysctl_class != '' {
    include $sysctl_class
  }

  if $time_class and $time_class != '' {
    include $time_class
  }

  if $mail_class and $mail_class != '' {
    include $mail_class
  }

  if $access_class and $access_class != '' {
    include $access_class
  }

  if $monitor_class and $monitor_class != '' {
    include $monitor_class
  }

  if $backup_class and $backup_class != '' {
    include $backup_class
  }

  if $users_class and $users_class != '' {
    include $users_class
  }

  if $firewall_class and $firewall_class != '' {
    include $firewall_class
  }

  if $logs_class and $logs_class != '' {
    include $logs_class
  }

  if $hardening_class and $hardening_class != '' {
    include $hardening_class
  }

  # Role specific class is loaded, if $role is set
  if $role and $role != '' {
    include "::site::role::${role}"
  }
}
