%{
#include "global.h"
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int division_by_zero = 0;

void check_division_by_zero(int num){
  if (num == 1){
    printf("Divisão por zero encontrada!!\n");
    division_by_zero = 0;
  }
}

%}

%token END
%token DIVIDE TIMES PLUS MINUS POW
%token NUMBER
%token LEFT_PARENTHESIS RIGHT_PARENTHESIS COMMA

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
        if(division_by_zero == 0)
            printf("Resultado: %f", $1);
        check_division_by_zero(division_by_zero); 
      }
Expression:
   NUMBER                                           { $$=$1; }
   | POW LEFT_PARENTHESIS Expression COMMA Expression RIGHT_PARENTHESIS { 
        $$=pow($3,$5); }
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
