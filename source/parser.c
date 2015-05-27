#include "global.h"
#include "parser.h"
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

const true = 1;
const false = 0;


void add_symbol_to_table (node *list, char * symbol,int flag_atribution,int value){
     node *var = find_by_scope(list,list->next->scope,symbol);

     if(var)
         return;

     node *new_node = (node *) malloc(sizeof(node));
     new_node->scope = list->next->scope;

     if(flag_atribution)
     {
         new_node->symbol = symbol;
         new_node->inicialized = 1;
         new_node->value = value;
         insert_symbol(list, new_node);
     }
     else
     {
         new_node->symbol = symbol;
         new_node->inicialized = 0;
         new_node->value = 0;
         insert_symbol(list, new_node);
     }
}

int check_vulnerability(node * list, char symbol[40],int flag_atribution)
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

void check_uninitialized_vars(line *code_table, node * list, int atribution, char * symbol, int symbol_value)
{
    int result = check_vulnerability(list, symbol, atribution);
    if(result)
    {
        insert_line(code_table, "Vulnerabilidade encontrada!!", 4);
        puts("Vulnerabilidade encontrada");
    }
    else
        add_symbol_to_table(list, symbol, atribution, symbol_value);
}

void set_scope(char *symbol)
{
    node *new_node = (node *) malloc(sizeof(node));
    new_node->symbol = symbol;
    new_node->scope = symbol;
    insert_symbol(list, new_node);
}

int check_scope_vulnerability(node *list, char *method, char *symbol)
{

    if (!strcmp(method,"nil"))
        return false;

    node * check_node = find_by_scope(list, list->next->scope, symbol);
    node * scope_node = find_by_scope(list, method, symbol);

    if (!check_node->inicialized )
        if(!scope_node->inicialized)
            printf("Variavel %s, no escopo da funcao: %s, nao foi inicializada\n",symbol,method);

}
