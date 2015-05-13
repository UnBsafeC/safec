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



test_pass_several_vars_to_scope()
{
  out="$(echo  $several_vars_to_scope | ./safec)"
  expected="Variavel n, no escopo da funcao: sum, nao foi inicializada
Variavel p, no escopo da funcao: sub, nao foi inicializada
Variavel y, no escopo da funcao: sub, nao foi inicializada
Variavel z, no escopo da funcao: sub, nao foi inicializada"
  assertEquals  "$expected"   "$out"
}


test_pass_some_initialized_vars()
{
  out="$(echo  $some_initilized_vars | ./safec)"
  expected="Variavel z, no escopo da funcao: sub, nao foi inicializada
Variavel n, no escopo da funcao: sub, nao foi inicializada"
  assertEquals  "$expected"   "$out"
}
load_shunit2
