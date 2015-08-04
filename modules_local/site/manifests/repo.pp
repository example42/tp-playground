class site::repo {

  if $::osfamily == 'RedHat' {
    tp::repo { 'epel': }
  }

}
