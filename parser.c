#include "global.h"
#include "parser.h"
#include <stdio.h>
#include <stdlib.h>
#include <math.h>


void add_symbol_to_table (char * symbol,int flag_atribution,int value){
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


int check_vulnerability(node * list, char symbol[40],int flag_atribution)
{

    if(flag_atribution)
        return 0;

    node * check_node = find_symbol(list, symbol);

    if(check_node){

        if(check_node->inicialized)
            return 0;
        else
            return 1;
    }
    return 0;
}

void check_uninitialized_vars(node * list, int atribution, char * symbol, int symbol_value)
{
    int result = check_vulnerability(list, symbol, atribution);
    if(result)
        puts("Vulnerabilidade encontrada");
    else
        add_symbol_to_table(symbol, atribution, symbol_value);
}

void set_scope(char *symbol)
{
    node *new_node = (node *) malloc(sizeof(node));
    new_node->symbol = symbol;
    new_node->scope = symbol;
    insert_symbol(list, new_node);
}

