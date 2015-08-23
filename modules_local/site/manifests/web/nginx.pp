class site::web::nginx {

  ::tp::install { 'nginx' : }
  $nginx_options = {
    'worker_processes'   => '12',
    'worker_connections' => '512',
  }
  tp::conf { 'nginx':
    template     => 'site/nginx/nginx.conf.erb',
    options_hash => $nginx_options,
  }

}
