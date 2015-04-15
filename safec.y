%{
#include "global.h"
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int division_by_zero = 0;

void check_division_by_zero(int num){
  if (num == 1){
    printf("divisão por zero encontrada \n");
    division_by_zero = 0;
  }
  else
    printf("Está tudo ok \n");
}

%}

%token END
%token DIVIDE TIMES PLUS MINUS
%token NUMBER
%token LEFT_PARENTHESIS RIGHT_PARENTHESIS

%left PLUS MINUS
%left DIVIDE TIMES
%left NEG

%start Input

%%

Input:
    | Input Line
    ;
Line:
    END
    | Expression END { 
        check_division_by_zero(division_by_zero); 
        printf("Resultado: %f", $1);
      }
Expression:
   NUMBER                                           { $$=$1; }
   | Expression PLUS Expression                     { $$=$1+$3; }
   | Expression MINUS Expression                    { $$=$1-$3; }
   | Expression TIMES Expression                    { $$=$1*$3; }
   | Expression DIVIDE Expression { 
        if($3 == 0.0)
            division_by_zero = 1;
        else
            $$ = $1/$3;
      }
   | MINUS Expression %prec NEG                     { $$=-$2; }
   | LEFT_PARENTHESIS Expression RIGHT_PARENTHESIS  { $$=$2; }
   ;

%%

int yyerror(char *s) {
   printf("%s\n",s);
}

int main(void) {
   yyparse();
}
