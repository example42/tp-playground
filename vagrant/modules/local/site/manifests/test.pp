# Some basic tests

class site::test {

  #  tp::conf { 'openssh::ssh_config':
  #  content => "# test test.conf\n",
  # }


  tp::dir { 'test':
    path        => '/opt/tp_self',
    source      => 'https://github.com/example42/puppet-tp/',
    vcsrepo     => 'git',
  }

}
