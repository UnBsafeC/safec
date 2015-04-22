. $(dirname $0)/test_helper.sh

test_explicit_and_simple_dbz() {
  out="$(echo {1/0} | ./safec)"
  assertEquals "$out" "Divisão por zero encontrada!!"
}

test_simple_expression_with_dbz() {
  out="$(echo {2/\(5-5\)} | ./safec)"
  assertEquals "$out" "Divisão por zero encontrada!!"
}

test_more_complex_expression_with_dbz() {
  out="$(./safec tests/examples/dbz)"
  out_without_spaces="$(echo $out | sed -e 's/^[ \t]*//')"
  assertEquals "$out_without_spaces" "Divisão por zero encontrada!!"
}

load_shunit2
