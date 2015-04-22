#! /bin/bash
. "$SHUNIT_HOME/shUnit"


TestBasic() {
  var1="$(echo {1/0} | ./safec)"
  var2="Divisão por zero encontrada!!"
  [ "${var1}" = "${var2}" ]
  shuAssert 'Division by zero finded' $?
  }
 
  shuStart
