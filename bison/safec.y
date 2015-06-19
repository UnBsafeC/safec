%{
#include "global.h"
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

extern FILE *yyin;
extern node * list;
extern line * code_table;
extern int step_compile;
extern int line_number;
char * local_scope = "nil";

int division_by_zero = 0;

void check_division_by_zero()
    {

            char msg[100];
            snprintf(msg, 100,"/*Divisao explicita por zero encontrada!!*/\n");
            insert_line(code_table, msg, line_number);
    }

void check_implicite_division_by_zero(node *list, char * variable)
    {
        node * method_identifier = find_by_scope(list, list->next->scope, variable);
        node * main_identifier = find_by_scope(list, "main", variable);

        /* checa primeiro se foi inicializado na main, depois no método em questão*/
        if (main_identifier->inicialized && main_identifier->value == 0)
        {
                    char msg[100];
                    snprintf(msg,100,  "/*Divisao invalida: Voce inicializou a variavel %s com zero!!*/\n", variable);
                    insert_line(code_table, msg, line_number);
        }

        else if (method_identifier->inicialized && method_identifier->value == 0)
        {
                    char msg[100];
                    snprintf(msg,100,  "/*Divisao invalida: Voce inicializou a variavel %s com zero!!*/\n", variable);
                    insert_line(code_table, msg, line_number);
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
    : INCLUDES
    ;

Line
    : END
    | Expression ';'
    | INT Atribution ';'
    | Atribution ';'
    | Declaration '{'

Expression
   : NUMBER
        {
            if (step_compile == 2)
                $$=$1;
        }
   | IDENTIFIER
        {
        if (step_compile == 1)
        {
            int atribution = 0;
            check_uninitialized_vars(code_table, list,
                                     atribution, $1,
                                     0,line_number);
        }
        else
            check_implicite_division_by_zero(list, $1);
        }
   | SQRT '(' Expression ')'
        {
            if(step_compile == 2)
                $$=sqrt($3);
        }
   | POW '(' Expression ',' Expression ')'
        {
            if(step_compile == 2)
                $$=pow($3,$5);
        }
   | Expression '+' Expression
        {
            if(step_compile == 2)
                $$=$1+$3;
        }
   | Expression '-' Expression
        {
            if(step_compile == 2)
                $$=$1-$3;
        }
   | Expression '*' Expression
        {
            if(step_compile == 2)
                $$=$1*$3;
        }
   | Expression '/' Expression
        {
            if(step_compile == 2)
            {
                if($3 == 0.0)
                {
                    check_division_by_zero();
                }
                else
                    $$ = $1/$3;
            }
        }
   | '-' Expression %prec '-'
        {
            if(step_compile == 2)
                $$=-$2;
        }
   | '(' Expression ')'
        {
            if(step_compile == 2)
                $$=$2;
        }
   ;

Declaration
    : INT IDENTIFIER '(' {  set_scope($2); }  Params ')'
    ;

Params
    : IDENTIFIER
        {
            if (step_compile == 1)
                check_scope_vulnerability(list, local_scope,
                                            $1, line_number);
        }
    | IDENTIFIER ',' Params
        {
            if (step_compile == 1)
                check_scope_vulnerability(list, local_scope,
                                            $1, line_number );
        }
    |
    ;

Atribution
    : IDENTIFIER
        {
            if (step_compile == 1)
            {
                int atribution = 0;
                check_uninitialized_vars(code_table, list,  atribution,
                                        $1, 0,line_number);
            }
        }
    | IDENTIFIER '=' Expression
        {
            if (step_compile == 1)
            {
                int atribution = 1;
                check_uninitialized_vars(code_table, list,
                                         atribution, $1,
                                         $3, line_number);
            }
        }
    | IDENTIFIER '(' { local_scope = $1; }  Params ')'
    ;

%%

int yyerror(char *message)
{
   printf("Message error: %s (line: %d)\n", message, line_number);
}


void copy_to_final_file(FILE * in_file)
{
    FILE *final_file;
    FILE *source;
    char ch;

    mkdir("output/", 0700);
    final_file = fopen( "output/safec.c" , "w");

    while(1)
    {
        ch = fgetc(in_file);
        if(ch == EOF)
        {
            fclose(in_file);
            break;
        }
        else
            fputc(ch, final_file);
    }

    fclose(final_file);
}

int main(int argc, char *argv[])
{

    step_compile = 1;

    if(argc == 2)
    {
        FILE *input = fopen(argv[1],"r");
        FILE * copy_input = fopen(argv[1],"r");
        copy_to_final_file(copy_input);
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
    code_table = create_code_table();
    fill_code_table(code_table);
    while (!feof(yyin))
    {
        yyparse();
    }

    FILE * re_input = fopen("output/safec.c","r");
    yyin = re_input;
    step_compile = 2;
    line_number = 1;

    while (!feof(yyin))
    {
        yyparse();
    }

    puts("Genrating output file, check output/safec.c");

    write_code_table(code_table);

    return 0;
}
