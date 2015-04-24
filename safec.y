%{
#include "global.h"
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

extern int line_number;
extern FILE *yyin;
extern node * list;
int division_by_zero = 0;

void check_division_by_zero(int num){
  if (num == 1){
    printf("Divisão por zero encontrada!!\n");
    division_by_zero = 0;
  }
}

 void add_symbol_to_table (char symbol){
 }

%}

%union {
  double val;
  char *symbol;
}


%token DIVIDE TIMES PLUS MINUS POW SQRT
%token <val> NUMBER
%token END
%token LEFT_PARENTHESIS RIGHT_PARENTHESIS COMMA

%left PLUS MINUS
%left DIVIDE TIMES
%left NEG

%token END_FILE START_FILE
%token INCLUDES MAIN

%token INT FLOAT DOT_COMMA

%token <symbol> VARIABLE
%type <val> Expression

%start Input

%%

Input:
     | Input Stream

Stream:
    END_FILE
    | START_FILE Line
    | Line
    | Syntax

Syntax:
     INCLUDES
    | MAIN
    ;

Line:
    END
    | Declaration
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

/* Por enquanto estamos pegando apenas variaveis to tipo int e float,
mas basta adicionar os tokens para os outros tipos */
Declaration:
    /* Verificar porque $1[0] não é uma string */
    VARIABLE       {puts ("SYMBOL"); puts($1);}
    | INT Declaration DOT_COMMA
    | FLOAT Declaration DOT_COMMA
    ;

%%

int yyerror(char *message) {
   printf("Message error: %s (line: %d)\n", message, line_number);
}

int main(int argc, char *argv[]) {

   if(argc == 2) {
      FILE *input = fopen(argv[1],"r");
      yyin = input;
    if(input == 0) {
          printf( "Could not open file\n" );
          exit -1;
    }
   }
   else
    yyin = stdin;

    while (!feof(yyin)){
      return yyparse();
    }

   return 0;
}
