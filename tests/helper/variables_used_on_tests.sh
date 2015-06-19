unitialized_var="
#include <stdlib.h>\n
#include <stdio.h>\n
 
int main(){
   int a;
   a;
}"

initialized_var="
#include <stdlib.h>\n
#include <stdio.h>\n
    
int main(){
    int a = 5;
    a;
}"   

several_initialized_vars="
#include <stdlib.h>\n
#include <stdio.h>\n
 
int main(){
    int a;
    int b;
    int c;
    c = 5;
    a = 5;
    b = 5;
}"

several_unitialized_vars="
#include <stdlib.h>\n
#include <stdio.h>\n

int main(){
    int a;
    int b;
    int c;
    c;
    b = 5;
}"

initialized_var_with_simple_expression="
#include <stdlib.h>\n
#include <stdio.h>\n

int main(){
    int a;
    a = 2+2;
}"

initialized_var_with_more_complex_expression="
#include <stdlib.h>\n
#include <stdio.h>\n
 
int main(){
    int a;
    a = sqrt(pow(((2*4)/3),2)-1);
}"
