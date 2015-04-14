# General baseline, common to all the nodes
#
class site::general {

  include site::test

  ::tp::install { 'openssh': }

  # Sample sudo entry
  ::tp::conf { 'sudo::admin':
    content => "## admin ALL=NOPASSWD:ALL\n",
  }
  
  # Postfix as local mailer
  ::tp::install { 'postfix': }
  ::tp::conf { 'postfix':
    template     => hiera('tp::postfix::template', undef),
    options_hash => hiera('tp::postfix::options', { } ),
  }

}
