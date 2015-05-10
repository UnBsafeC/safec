. $(dirname $0)/helper/test_helper.sh

# Use variables_used_on_tests file
 #to declare the variables called after "echo" on each test.
. $(dirname $0)/helper/scope_variables.sh


test_pass_uninitialized_var_to_func()
{
  out="$(echo  $pass_uninitialized_var | ./safec)"
  expected="Variavel n, no escopo da funcao: sum, nao foi inicializada"
  assertEquals  "$expected"   "$out"
}


test_pass_initialized_var_to_func()
{
  out="$(echo  $pass_initialized_var | ./safec)"
  expected=""
  assertEquals  "$expected"   "$out"
}


test_initialize_var_inside_scope()
{
  out="$(echo  $pass_initialized_var_in_main | ./safec)"
  expected=""
  assertEquals  "$expected"   "$out"
}
load_shunit2
