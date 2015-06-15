. $(dirname $0)/helper/test_helper.sh

# Use variables_used_on_tests file
 #to declare the variables called after "echo" on each test.
. $(dirname $0)/helper/scope_variables.sh

test_pass_uninitialized_var_to_func()
{
  ./safec tests/helper/scope_test_case/pass_unitialized_var.c
  output=$(grep -r "variavel n, no escopo da funcao: sum, nao foi inicializada" output/safec.c )
  msg="/*variavel n, no escopo da funcao: sum, nao foi inicializada*/"
  assertEquals "$output" "$msg"

}


test_pass_initialized_var_to_func()
{
  ./safec tests/helper/scope_test_case/pass_initialized_var.c
  output=$(grep -r "variavel n, no escopo da funcao: sum, nao foi inicializada" output/safec.c )
  msg=""
  assertEquals "$output" "$msg"
}


test_initialize_var_inside_scope()
{
  ./safec tests/helper/scope_test_case/pass_unitialized_var_in_main.c
  output=$(grep -r "variavel n, no escopo da funcao: sum, nao foi inicializada" output/safec.c )
  msg=""
  assertEquals "$output" "$msg"
}

test_pass_several_vars_to_scope()
{
  ./safec tests/helper/scope_test_case/several_vars_to_scope.c
  outputN=$(grep -r "variavel n, no escopo da funcao: sum, nao foi inicializada" output/safec.c )
  outputP=$(grep -r "variavel p, no escopo da funcao: sub, nao foi inicializada" output/safec.c )
  outputY=$(grep -r "variavel y, no escopo da funcao: sub, nao foi inicializada" output/safec.c )
  outputZ=$(grep -r "variavel z, no escopo da funcao: sub, nao foi inicializada" output/safec.c )
  msgN="/*variavel n, no escopo da funcao: sum, nao foi inicializada*/"
  msgP="/*variavel p, no escopo da funcao: sub, nao foi inicializada*/"
  msgY="/*variavel y, no escopo da funcao: sub, nao foi inicializada*/"
  msgZ="/*variavel z, no escopo da funcao: sub, nao foi inicializada*/"

  assertEquals "$outputN" "$msgN"
  assertEquals "$outputP" "$msgP"
  assertEquals "$outputY" "$msgY"
  assertEquals "$outputZ" "$msgZ"
}


test_pass_some_initialized_vars()
{
  ./safec tests/helper/scope_test_case/some_initialized_vars.c
  output=$(grep -r "variavel n, no escopo da funcao: sum, nao foi inicializada" output/safec.c )
  msg=""
  assertEquals "$output" "$msg"
}
load_shunit2
