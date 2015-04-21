%{
#include "global.h"
#include <stdio.h>
#include <stdlib.h>
#include <math.h>



extern int line_number;
extern FILE *yyin;
int division_by_zero = 0;

void check_division_by_zero(int num){
  if (num == 1){
    printf("Divisão por zero encontrada!!\n");
    division_by_zero = 0;
  }
}

%}

%token END 
%token START 
%token DIVIDE TIMES PLUS MINUS POW SQRT
%token NUMBER
%token LEFT_PARENTHESIS RIGHT_PARENTHESIS COMMA

%left PLUS MINUS
%left DIVIDE TIMES
%left NEG

%start Input

%%

Input:
    /* Para ler corretamente de um arquivo de testes, foi preciso
    definir uma estrutura basica, que pode evoluir para um arquivo em c.
    O arquivo exemplo esta em examples/sample_input */
    | Input START Line
    | Input Line
    /* yywrap() encerra a leitura do yyparse(), quando o "}" e encontrado */
    | Input Line END { yywrap(); }

    ;
Line:
    END
    | Expression { 
        if(division_by_zero == 0)
            printf("Resultado : %f\n", $1);
        check_division_by_zero(division_by_zero); 
      }

Expression:
   NUMBER                                               { $$=$1; }
   | SQRT LEFT_PARENTHESIS Expression RIGHT_PARENTHESIS { $$=sqrt($3); }
   | POW LEFT_PARENTHESIS Expression COMMA Expression RIGHT_PARENTHESIS { 
        $$=pow($3,$5); }
   | Expression PLUS Expression                         { $$=$1+$3; }
   | Expression MINUS Expression                        { $$=$1-$3; }
   | Expression TIMES Expression                        { $$=$1*$3; }
   | Expression DIVIDE Expression { 
        if($3 == 0.0){
            division_by_zero = 1;
            $$ = 0;
            }
        else{
            $$ = $1/$3;
            }
      }
   | MINUS Expression %prec NEG                         { $$=-$2; }
   | LEFT_PARENTHESIS Expression RIGHT_PARENTHESIS      { $$=$2; }
   ;

%%

int yyerror(char *message) {
   printf("Message error: %s (line: %d)\n", message, line_number);
}

int main(int argc, char *argv[]) {
   if(argc != 2) {
        printf("We need a input file as argumment!\nUsage: safec <input_file>\n"); 
        exit -1;
   }

   FILE *input = fopen(argv[1],"r");

   if(input == 0) {
        printf( "Could not open file\n" );
        exit -1;
   }

   yyin = input;

    while (!feof(yyin)){
      return yyparse();
    }

   return 0;
}
