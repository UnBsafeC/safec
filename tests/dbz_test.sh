. $(dirname $0)/test_helper.sh

test_explicit_and_simple_dbz() {
  out="$(echo {1/0} | ./safec)"
  assertEquals "$out" "Divisão por zero encontrada!!"
}

load_shunit2
