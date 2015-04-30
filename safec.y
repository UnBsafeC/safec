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

void add_symbol_to_table (char * symbol,int flag_atribution,int value){
    node *new_node = (node *) malloc(sizeof(node));
    list = create_list();
    new_node->symbol = symbol;
    new_node->inicialized = 0;
    new_node->value = 0;
    if (flag_atribution){
        new_node->inicialized = 1;
        new_node->value=value;
        new_node->symbol = symbol;
    }

    insert_symbol(list, new_node);
}


int check_vulnerability(node * list, char symbol[40],int flag_atribution)
{

    if(flag_atribution)
        return 0;

    node * check_node = find_symbol(list, symbol);

    if(check_node){

        if(check_node->inicialized)
            return 0;

        return 1;
    }
    return 0;
}

int check_uninitialized_vars(node * list, int atribution, char * symbol, int symbol_value)
{
    int result = check_vulnerability(list, symbol, atribution);
    if(result)
        puts("Vulnerabilidade encontrada");
    else
        add_symbol_to_table(symbol, atribution, symbol_value);
}


%}

%union {
    double val;
    char *symbol;
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
%token INCLUDES MAIN

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
    | MAIN
    ;

Line
    :END
    | Declaration
    | Expression {
                    if(division_by_zero == 0)
                    printf("Resultado : %f\n", $1);
                    check_division_by_zero(division_by_zero);
                 }

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
    : DOT_COMMA
    | INT Atribution DOT_COMMA
    | FLOAT Atribution DOT_COMMA
    | Atribution DOT_COMMA
    ;
Atribution
    :VARIABLE                {
                                int atribution = 0;
                                check_uninitialized_vars(list, atribution, $1, 0);
                             }
    | VARIABLE EQUALS NUMBER {
                                int atribution = 1;
                                check_uninitialized_vars(list, atribution, $1, $3);
                             }
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
