pass_uninitialized_var="
#include <stdlib.h>\n
#include <stdio.h>\n

int sum(n){
    n;
}

int main(){
    int n;
    sum(n);
}"


pass_initialized_var="
#include <stdlib.h>\n
#include <stdio.h>\n

int sum(n){
    n;
}

int main(){
    int n=5;
    sum(n);
}"


pass_uninitialized_var_in_main="
#include <stdlib.h>\n
#include <stdio.h>\n

int sum(n){
    n=5;
}

int main(){
    int n;
    sum(n);
}"


several_vars_to_scope="
#include <stdlib.h>\n
#include <stdio.h>\n

int sum(n)
{
    n;
}

int sub(n,y,z)
{
    y;
    z;
    n=5;
    p;
}

int main()
{
    int n;
    int y;
    int z;
    int p;
    sum(n);
    sub(n,z,y,p);
}
"



some_initilized_vars="
#include <stdlib.h>\n
#include <stdio.h>\n

int sum(n)
{
    n=1;
}

int sub(n,y,z)
{
    y;
    z;
    n;
    p=2;
}

int main()
{
    int n;
    int y=3;
    int z;
    int p;
    sum(n);
    sub(n,z,y,p);
}
"
