. $(dirname $0)/helper/test_helper.sh

. $(dirname $0)/helper/dbz_variables.sh


test_explicit_and_simple_dbz() {
  ./safec tests/helper/dbz_test_case/simple_dbz.c
  output=$(cat output/safec.c )
  msg="/*Divisao explicita por zero encontrada!!*/"
  output=*$msg*
  assertEquals "$output" "*$msg*"
}

test_simple_expression_with_dbz() {
  ./safec tests/helper/dbz_test_case/simple_expression_with_dbz.c
  output=$(cat output/safec.c )
  msg="/*Divisao explicita por zero encontrada!!*/"
  output=*$msg*
  assertEquals "$output" "*$msg*"
}

test_more_complex_expression_with_dbz() {
  ./safec tests/helper/dbz_test_case/more_complex_experssion_with_dbz.c
  output=$(cat output/safec.c )
  msg="/*Divisao por zero encontrada!!*/"
  output=*$msg*
  assertEquals "$output" "*$msg*"
}

test_declare_variable_with_zero() {
  ./safec tests/helper/dbz_test_case/declare_variable_with_zero.c
  output=$(cat output/safec.c )
  msg="/*Divisao por zero encontrada!!*/"
  output=*$msg*
  assertEquals "$output" "*$msg*"
}


test_declare_division_by_zero_as_expression() {
  ./safec tests/helper/dbz_test_case/declare_division_by_zero_as_expression.c
  output=$(cat output/safec.c )
  msg="/*Divisao por zero encontrada!!*/"
  output=*$msg*
  assertEquals "$output" "*$msg*"
}

load_shunit2
