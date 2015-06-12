. $(dirname $0)/helper/test_helper.sh

# Use variables_used_on_tests file
 #to declare the variables called after "echo" on each test.
. $(dirname $0)/helper/scope_variables.sh

./safec tests/helper/scope_test_case/pass_initialized_var.c
output=$(cat output/safec.c )
msg="/*Vulnerabilidade encontrada*/"
output=*$msg*
assertEquals "$output" "*$msg*"


test_pass_uninitialized_var_to_func()
{
  ./safec tests/helper/scope_test_case/pass_uninitialized_var.c
  output=$(cat output/safec.c )
  msg="/*Variavel n, no escopo da funcao: sum, nao foi inicializada*/"
  output=*$msg*
  assertEquals "$output" "*$msg*"

}


test_pass_initialized_var_to_func()
{
  ./safec tests/helper/scope_test_case/pass_initialized_var.c
  output=$(cat output/safec.c )
  msg=""
  output=*$msg*
  assertEquals "$output" "*$msg*"
}


test_initialize_var_inside_scope()
{
  ./safec tests/helper/scope_test_case/pass_initialized_var_in_main.c
  output=$(cat output/safec.c )
  msg=""
  output=*$msg*
  assertEquals "$output" "*$msg*"
}

test_pass_several_vars_to_scope()
{
  ./safec tests/helper/scope_test_case/several_vars_to_scope.c
  output=$(cat output/safec.c )
  msg="/*Variavel n, no escopo da funcao: sum, nao foi inicializada
  Variavel p, no escopo da funcao: sub, nao foi inicializada
  Variavel y, no escopo da funcao: sub, nao foi inicializada
  Variavel z, no escopo da funcao: sub, nao foi inicializada */"
  output=*$msg*
  assertEquals "$output" "*$msg*"
}


test_pass_some_initialized_vars()
{
  ./safec tests/helper/scope_test_case/some_initialized_vars.c
  output=$(cat output/safec.c )
  msg=""
  output=*$msg*
  assertEquals "$output" "*$msg*"
}
load_shunit2
