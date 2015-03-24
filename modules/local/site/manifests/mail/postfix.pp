class site::mail::postfix {

  ::tp::install { 'postfix': }
  ::tp::conf { 'postfix':
    template     => $template,
    options_hash => $options,
  }

}
