class test_params (
  $one = params_lookup('one'),
  $two = params_lookup('two'),
  $monitor = params_lookup('monitor','global'),
) {

  notify { "one: ${one}": }
  notify { "two: ${two}": }
  notify { "monitor: ${monitor}": }
 
}
