simple_dbz="
#include <stdlib.h>\n
#include <stdio.h>\n

int main(){
1/0
}"


simple_expression_with_dbz="
#include <stdlib.h>\n
#include <stdio.h>\n

int main(){
2/(5-5)
}"


more_complex_expression_with_dbz="
#include <stdlib.h>\n
#include <stdio.h>\n

int main(){
((2*3) - sqrt(4))/(4 - pow(2,2))
}"

declare_variable_with_zero="
#include <stdlib.h>\n
#include <stdio.h>\n
int main(){
int a = 0;
2/a
}"


declare_division_by_zero_as_expression="
#include <stdlib.h>\n
#include <stdio.h>\n

int main(){
    int n = 0;
    int b = 2/n;
}
"

