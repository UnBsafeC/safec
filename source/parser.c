#include "global.h"
#include "parser.h"
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

const true = 1;
const false = 0;


void add_symbol_to_table (char * symbol,int flag_atribution,int value)
{
    node *new_node = (node *) malloc(sizeof(node));
    new_node->symbol = symbol;
    new_node->inicialized = 0;
    new_node->value = 0;

    new_node->scope = list->next->scope;

    if (flag_atribution){
        new_node->inicialized = 1;
        new_node->value=value;
        new_node->symbol = symbol;
    }

    insert_symbol(list, new_node);
}


int variable_was_initialized(node * list, char symbol[40],int flag_atribution)
{

    if(flag_atribution)
        return false;

    node * check_node = find_by_scope(list, list->next->scope, symbol);

    if(check_node){

        if(check_node->inicialized)
            return false;

        return true;
    }
    return false;
}

void check_uninitialized_vars(node * list, int atribution, char * variable, int var_value)
{
    int result = variable_was_initialized(list, variable, atribution);
    if(result)
        puts("Vulnerabilidade encontrada");
    else
        add_symbol_to_table(variable, atribution, var_value);
}

void set_scope(char *symbol)
{
    node *new_node = (node *) malloc(sizeof(node));
    new_node->symbol = symbol;
    new_node->scope = symbol;
    insert_symbol(list, new_node);
}

int check_scope_vulnerability(node *list, char *func_inside_main_scope, char *symbol)
{


    /* func_inside_main_scope me informa o nome da funcao que foi chamada dentro da main.
     * Se ela vier "nil", é porque a funcao ainda nao foi chamada */
    if (!strcmp(func_inside_main_scope,"nil"))
        return false;

    char *main_scope = list->next->scope;
    node * main_scope_variable = find_by_scope(list, main_scope, symbol);
    node * func_scope_variable = find_by_scope(list, func_inside_main_scope, symbol);

    if (!main_scope_variable->inicialized )
        if(!func_scope_variable->inicialized)
            printf("Variavel %s, no escopo da funcao: %s, nao foi inicializada\n",symbol,func_inside_main_scope);

}

void check_implicite_division_by_zero(node *list, char * variable)
    {
            node * identifier = find_by_scope(list, list->next->scope, variable);
            if (identifier->inicialized)
                if(identifier->value == 0)
                puts("Divisão por zero encontrada!!");
    }
