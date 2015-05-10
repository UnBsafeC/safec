. $(dirname $0)/helper/test_helper.sh

# Use variables_used_on_tests file
 #to declare the variables called after "echo" on each test.
. $(dirname $0)/helper/variables_used_on_tests.sh


test_uninitiliazed_variable()
{
  out="$(echo  $uninitialized_var | ./safec)"
  answer='Vulnerabilidade encontrada'
  assertEquals  "$answer"   "$out"
}

test_initiliazed_variable()
{
  out="$(echo  $initialized_var | ./safec)"
  assertEquals  ""   "$out"
}

test_several_initialized_variables()
{
  out="$(echo  $several_initialized_vars | ./safec)"
  assertEquals  ""   "$out"
}


test_several_uninitialized_variables()
{
  out="$(echo  $several_uninitialized_vars | ./safec)"
  answer="Vulnerabilidade encontrada"
  assertEquals  "$answer"   "$out"
}

test_initialized_var_with_simple_expression()
{
  out="$(echo  $initialized_var_with_simple_expression | ./safec)"
  assertEquals  ""   "$out"
}

test_initialized_var_with_more_complex_expression()
{
  out="$(echo  $initialized_var_with_more_complex_expression | ./safec)"
  assertEquals  ""   "$out"
}

load_shunit2
