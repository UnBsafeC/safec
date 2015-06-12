. $(dirname $0)/helper/test_helper.sh

# Use variables_used_on_tests file
 #to declare the variables called after "echo" on each test.
. $(dirname $0)/helper/variables_used_on_tests.sh

test_uninitiliazed_variable()
{
  ./safec tests/helper/uv_test_case/simple_dbz.c
  output=$(cat output/safec.c )
  msg="/*Vulnerabilidade encontrada*/"
  output=*$msg*
  assertEquals "$output" "*$msg*"

}

test_initiliazed_variable()
{
  ./safec tests/helper/uv_test_case/initialized_var_dbz.c
  output=$(cat output/safec.c )
  msg="/*Vulnerabilidade encontrada*/"
  output=*$msg*
  assertEquals "$output" "*$msg*"

}

test_several_initialized_variables()
{
  ./safec tests/helper/uv_test_case/several_initialized_var_dbz.c
  output=$(cat output/safec.c )
  msg="/*Vulnerabilidade encontrada*/"
  output=*$msg*
  assertEquals "$output" "*$msg*"

}


test_several_uninitialized_variables()
{
  ./safec tests/helper/uv_test_case/several_uninitialized_var_dbz.c
  output=$(cat output/safec.c )
  msg="/*Vulnerabilidade encontrada*/"
  output=*$msg*
  assertEquals "$output" "*$msg*"
}

test_initialized_var_with_simple_expression()
{
  ./safec tests/helper/uv_test_case/initialized_var_with_simple_expression.c
  output=$(cat output/safec.c )
  msg="/*Vulnerabilidade encontrada*/"
  output=*$msg*
  assertEquals "$output" "*$msg*"
}

test_initialized_var_with_more_complex_expression()
{
  ./safec tests/helper/uv_test_case/initialized_var_with_more_complex_expression.c
  output=$(cat output/safec.c )
  msg="/*Vulnerabilidade encontrada*/"
  output=*$msg*
  assertEquals "$output" "*$msg*"
}

load_shunit2
