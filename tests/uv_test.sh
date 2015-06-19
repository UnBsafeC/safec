. $(dirname $0)/helper/test_helper.sh

# Use variables_used_on_tests file
 #to declare the variables called after "echo" on each test.
. $(dirname $0)/helper/variables_used_on_tests.sh

test_unitiliazed_variable()
{
  ./safec tests/helper/uv_test_case/unitialized_var.c
  output=$(grep -r "Variavel a nao foi inicializada!! " output/safec.c)
  msg="/*Variavel a nao foi inicializada!! */"
  assertEquals "$output" "$msg"
}

test_initiliazed_variable()
{
  ./safec tests/helper/uv_test_case/initialized_var.c
  output=$(grep -r "Variavel a nao foi inicializada!! " output/safec.c)
  msg=""
  assertEquals "$output" "$msg"
}

test_several_initialized_variables()
{
  ./safec tests/helper/uv_test_case/several_initialized_vars.c
  output=$(grep -r "Variavel a nao foi inicializada!! " output/safec.c)
  msg=""
  assertEquals "$output" "$msg"
}


test_several_unitialized_variables()
{
  ./safec tests/helper/uv_test_case/several_unitialized_vars.c
  output=$(grep -r "Variavel c nao foi inicializada!! " output/safec.c)
  msg="/*Variavel c nao foi inicializada!! */"
  assertEquals "$output" "$msg"
}

test_initialized_var_with_simple_expression()
{
  ./safec tests/helper/uv_test_case/initialized_var_with_simple_expression.c
  output=$(grep -r "Variavel c nao foi inicializada!! " output/safec.c)
  msg=""
  assertEquals "$output" "$msg"
}

test_initialized_var_with_more_complex_expression()
{
  ./safec tests/helper/uv_test_case/initialized_var_with_more_complex_expression.c
  output=$(grep -r "Variavel c nao foi inicializada!! " output/safec.c)
  msg=""
  assertEquals "$output" "$msg"
}

load_shunit2
