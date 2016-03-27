function site::boolean2ensure (
  $value
) {

  $output = $value ? {
    false                => 'absent',
    /^(0|f|n|false|no)$/ => 'absent',  
    true                 => 'present',
    ''                   => 'present',  
    /^(1|t|y|true|yes)$/ => 'present',  
    undef                => 'present',  
  }

}
