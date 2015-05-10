uninitialized_var="
{
  int main(){
    int a;
    a;
  }
}"

initialized_var="
{
    int main(){
    int a;
    a=5;
    }
}"

several_initialized_vars="
{
    int main(){
    int a;
    int b;
    int c;
    c = 5;
    a = 5;
    b = 5;
    }
}"

several_uninitialized_vars="
{
    int main(){
    int a;
    int b;
    int c;
    c;
    b = 5;
}
}"

initialized_var_with_simple_expression="
{
    int main(){
        int a;
        a = 2+2;
    }
}"

initialized_var_with_more_complex_expression="
{
    int main(){
    int a;
    a = sqrt(pow(((2*4)/3),2)-1);
    }
}"
