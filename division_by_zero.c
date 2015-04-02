#include <stdio.h>
#include <stdlib.h>

int main(){

  //É possível redirecionar um arquivo inteiro para o
  //safec. Basta dar um cat division_by_zero.c | ./safec
  //Ele vai pegar os includes e o main, mas irá reconhecer
  //a vulnerabilidade do 2/0;

  2/0;

}
