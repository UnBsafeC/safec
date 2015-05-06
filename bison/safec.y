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


%token DIVIDE TIMES PLUS MINUS POW SQRT
%token <val> NUMBER
%token END
%token LEFT_PARENTHESIS RIGHT_PARENTHESIS COMMA

%left PLUS MINUS
%left DIVIDE TIMES
%left NEG

%token END_FILE START_FILE
%token INCLUDES

%token INT FLOAT DOT_COMMA EQUALS

%token <symbol> VARIABLE
%type <val> Expression

%start Input

%%

Input:
    | Input Stream

Stream
    : END_FILE
    | START_FILE Line
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
   : NUMBER                                               { $$=$1; }
   | SQRT LEFT_PARENTHESIS Expression RIGHT_PARENTHESIS { $$=sqrt($3); }
   | POW LEFT_PARENTHESIS Expression COMMA Expression RIGHT_PARENTHESIS { $$=pow($3,$5); }
   | Expression PLUS Expression                         { $$=$1+$3; }
   | Expression MINUS Expression                        { $$=$1-$3; }
   | Expression TIMES Expression                        { $$=$1*$3; }
   | Expression DIVIDE Expression   {
                                        if($3 == 0.0)
                                        {
                                            division_by_zero = 1;
                                            $$ = 0;
                                        }
                                        else
                                        {
                                            $$ = $1/$3;
                                        }
                                    }
   | MINUS Expression %prec NEG                         { $$=-$2; }
   | LEFT_PARENTHESIS Expression RIGHT_PARENTHESIS      { $$=$2; }
   ;

Declaration
    :  END_FILE
    |  INT Atribution
    |  Atribution
    ;

Atribution
    : DOT_COMMA
    | VARIABLE                    {
                                    int atribution = 0;
                                    check_uninitialized_vars(list, atribution, $1, 0);
                                 }
    | VARIABLE EQUALS Expression {
                                    int atribution = 1;
                                    check_uninitialized_vars(list, atribution, $1, $3);
                                 }
    | Method
    ;

Method
    : VARIABLE LEFT_PARENTHESIS VARIABLE RIGHT_PARENTHESIS START_FILE {
                                                             set_scope($1);
                                                             }
    | VARIABLE LEFT_PARENTHESIS VARIABLE RIGHT_PARENTHESIS DOT_COMMA {
                                                        node * check_node = find_by_scope(list, $1,$3);
                                                        if (!check_node->inicialized)
                                                            printf("Variavel %s, no escopo da funcao: %s, nao foi inicializada\n",$3,$1);

                                                                     }
    | VARIABLE LEFT_PARENTHESIS RIGHT_PARENTHESIS START_FILE {
                                                                set_scope($1);
                                                             }
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
