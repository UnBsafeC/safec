. $(dirname $0)/helper/test_helper.sh

. $(dirname $0)/helper/dbz_variables.sh

test_explicit_and_simple_dbz() {
  out="$(echo $simple_dbz | ./safec)"
  assertEquals "$out" "Divisão por zero encontrada!!"
}

test_simple_expression_with_dbz() {
  out="$(echo $simple_expression_with_dbz | ./safec)"
  assertEquals "$out" "Divisão por zero encontrada!!"
}

test_more_complex_expression_with_dbz() {
  out="$(echo $more_complex_expression_with_dbz | ./safec)"
  assertEquals "$out" "Divisão por zero encontrada!!"
}

load_shunit2
