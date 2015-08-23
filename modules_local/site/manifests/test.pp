# Some basic tests

class site::test {

  # include site::web::nginx
  package { 'git': }
  ::tp::install4 { 'apache': }
  ::tp::conf4 { 'apache::testlog':
    base_dir => 'log',
    content  => '# test ',
  }
  ::tp::conf4 { 'apache::testconf':
    content  => '# test ',
  }

  tp::dir4 { 'test':
    path        => '/opt/tp_self',
    source      => 'https://github.com/example42/puppet-tp/',
    vcsrepo     => 'git',
  }

}
