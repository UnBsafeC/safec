%{
#include "global.h"
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int division_by_zero = 0;

void check_division_by_zero(int num){
  if (num == 1){
    printf("divisão por zero encontrada \n");
    //Para poder continuar inserindo valores;
    division_by_zero = 0;
  }
  else
    printf("Está tudo ok \n");
}

%}

%token END
%token TYPE
%token DIVIDE
%token SYMBOL
%token NUMBER


%start Input

%%

Input:
   | Input Line
   ;
Line:
  END
   | Expression END { check_division_by_zero(division_by_zero); }
Expression:
  NUMBER { $$ = $1; }
   /* $3 acessa o segundo Expression da regra abaixo */
   | Expression DIVIDE Expression { if ($3 == 0) division_by_zero = 1; }
   ;

%%

int yyerror(char *s) {
   printf("%s\n",s);
}

int main(void) {
   yyparse();
}
