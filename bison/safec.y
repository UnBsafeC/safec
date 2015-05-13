%{
#include "global.h"
#include "parser.h"
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

extern int line_number;
extern FILE *yyin;
extern node * list;
char * local_scope = "nil";

int division_by_zero = 0;

void check_division_by_zero(int num)
    {
        if (num == 1){
            printf("Divisão por zero encontrada!!\n");
            division_by_zero = 0;
        }
    }


%}

%union
{
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
    | Expression
                {
                    check_division_by_zero(division_by_zero);
                 }
    | INT Atribution ';'
    | Atribution ';'
    | Declaration '{'

Expression
   : NUMBER                                  { $$=$1; }
   | IDENTIFIER
        {
            node * identifier = find_by_scope(list, list->next->scope, $1);
            if (!identifier->inicialized)
            $$ = identifier->value;

        }
   | SQRT '(' Expression ')'                 { $$=sqrt($3); }
   | POW '(' Expression ',' Expression ')'   { $$=pow($3,$5); }
   | Expression '+' Expression               { $$=$1+$3; }
   | Expression '-' Expression               { $$=$1-$3; }
   | Expression '*' Expression               { $$=$1*$3; }
   | Expression '/' Expression
        {
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
    : INT IDENTIFIER '(' {  set_scope($2); }  Params ')'
    ;

Params
    : IDENTIFIER    { check_scope_vulnerability(list, local_scope, $1); }
    | IDENTIFIER ',' Params { check_scope_vulnerability(list, local_scope, $1); }

    |
    ;

Atribution
    : IDENTIFIER
        {
            int atribution = 0;
            check_uninitialized_vars(list, atribution, $1, 0);
        }
    |  IDENTIFIER '=' Expression
        {
            int atribution = 1;
            check_uninitialized_vars(list, atribution, $1, $3);
        }
    | IDENTIFIER '(' { local_scope = $1; }  Params ')'
    ;

%%

int yyerror(char *message)
{
   printf("Message error: %s (line: %d)\n", message, line_number);
}

int main(int argc, char *argv[])
{

    if(argc == 2)
    {
        FILE *input = fopen(argv[1],"r");
        yyin = input;
        if(input == 0)
        {
            printf( "Could not open file\n" );
            exit -1;
        }
   }
    else
        yyin = stdin;

    list = create_list();
    while (!feof(yyin))
    {
        return yyparse();
    }

    return 0;
}
