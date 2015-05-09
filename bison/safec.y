%{
#include "global.h"
#include "parser.h"
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

extern int line_number;
extern FILE *yyin;
extern node * list;
int division_by_zero = 0;

void check_division_by_zero(int num)
    {
        if (num == 1){
            printf("Divisão por zero encontrada!!\n");
            division_by_zero = 0;
        }
    }


%}

%union {
    double val;
    char *symbol;
    char *scope;
    int inicialized;
    int value;
}


%token '/' '*' '-' '+' POW SQRT
%token <val> NUMBER
%token END
%token '(' ')' ',' '{' '}' ';' '='
%token INT FLOAT


%token INCLUDES

%token <symbol> IDENTIFIER
%type <val> Expression

%start Input

%%

Input:
    | Input Stream

Stream
    : '}'
    | '{' Line
    | Line
    | Syntax

Syntax
    :INCLUDES
    ;

Line
    :END
    | Expression {
                    if(division_by_zero == 0)
                        printf("Resultado : %f\n", $1);
                    check_division_by_zero(division_by_zero);
                 }
    | Declaration

Expression
   : NUMBER                                  { $$=$1; }
   | SQRT '(' Expression ')'                 { $$=sqrt($3); }
   | POW '(' Expression ',' Expression ')'   { $$=pow($3,$5); }
   | Expression '+' Expression               { $$=$1+$3; }
   | Expression '-' Expression               { $$=$1-$3; }
   | Expression '*' Expression               { $$=$1*$3; }
   | Expression '/' Expression   {
         if($3 == 0.0)
         {
            division_by_zero = 1;
            $$ = 0;
         }
         else
            $$ = $1/$3;
      }
   | '-' Expression %prec '-'                { $$=-$2; }
   | '(' Expression ')'                      { $$=$2; }
   ;

Declaration
    :  INT Atribution
    |  Atribution
    ;

Atribution
    : ';'
    | IDENTIFIER  {
         int atribution = 0;
         check_uninitialized_vars(list, atribution, $1, 0);
      }
    | IDENTIFIER '=' Expression {
         int atribution = 1;
         check_uninitialized_vars(list, atribution, $1, $3);
      }
    | Method
    ;

Method
    : IDENTIFIER '(' IDENTIFIER ')' '{' { set_scope($1); }
    | IDENTIFIER '(' IDENTIFIER ')' ';' {
         node * check_node = find_by_scope(list, $1,$3);
         if (!check_node->inicialized)
               printf("Variavel %s, no escopo da funcao: %s, nao foi inicializada\n",$3,$1);
      }
    | IDENTIFIER '(' ')' '{' { set_scope($1); }
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

    list = create_list();
    while (!feof(yyin)){
      return yyparse();
    }

   return 0;
}
