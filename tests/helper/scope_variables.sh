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
