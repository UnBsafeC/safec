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
