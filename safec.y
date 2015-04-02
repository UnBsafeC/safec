%{
#include "global.h"
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int var = 0;
%}

%token END
%token TYPE
%token DIVIDE
%token SYMBOL
%token NUMBER


%start Input

%%

Input:
   /* Empty */
   | Input Line
   ;
Line:
  END
   | Expression END {if (var==1){ 
                      printf("divisão por zero encontrada"); 
                      //Para poder continuar inserindo valores;
                      var = 0;
                      }
                     else
                     printf("Está tudo ok \n");
                    }
   ;
Expression: 
  NUMBER { $$ = $1; }
   | Expression DIVIDE Expression { if ($3 == 0) var = 1; }
   ;

%%

int yyerror(char *s) {
   printf("%s\n",s);
}

int main(void) {
   yyparse();
}
