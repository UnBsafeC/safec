#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "symbol_table.h"
#define TRUE 1
#define FALSE 0

node * create_list(){
    node *list = (node *) malloc(sizeof(node));
    list->next = NULL;
    return list;
}

int is_empty(node *list_node ){

    if (list_node->next == NULL)
        return 1;

    return 0;
}

void insert_symbol(node *list_node, node *new_node){


    if(!new_node){
        printf("\nSEM MEMORIA DISPONIVEL \n");
        exit(1);
    }

    node *temp_node = list_node->next;
    list_node->next = new_node;

    new_node->next = temp_node;
}

node *find_symbol(node *node, char symbol[40]){

    int search_completed = FALSE;

    if( is_empty(node) ){
        return 0;
    }

    node_iterator = node->next;


    while(node_iterator != NULL){

      if( strcmp(symbol, node_iterator->symbol) == 0){
        search_completed = TRUE;
        return node_iterator;
      }

      node_iterator = node_iterator->next;
    }

    if( search_completed == FALSE){
        return NULL;
    }
}

node *find_by_scope(node *node, char scope[40], char symbol[40]){

    int search_completed = FALSE;

    if( is_empty(node) ){
        return 0;
    }

    node_iterator = node->next;


    while(node_iterator != NULL){

    if(strcmp(scope, node_iterator->scope) == 0){
      if( strcmp(symbol, node_iterator->symbol) == 0){
            search_completed = TRUE;
            return node_iterator;
            }
      }

      node_iterator = node_iterator->next;
    }

    if( search_completed == FALSE){
        return NULL;
    }
}

void destroy_list(node *node){

    if ( !is_empty(node) ){

        current_node = node->next;

        while (current_node != NULL) {
            next_node = current_node->next;
            free(current_node);
            current_node = next_node;
        }
    }
    puts("\nDestruindo lista!");
}

int delete_node(node *list, char symbol[40]){
    node_iterator = list->next;
    if(symbol == node_iterator->symbol){
        list->next = node_iterator->next;
        free(node_iterator->next);
        return 1;
    }
 
    while(node_iterator->next != NULL){
        if(symbol == node_iterator->next->symbol){
            if(node_iterator->next->next == NULL){
                node_iterator->next = NULL;
                free(node_iterator->next);
                return 2;
            } 
            else{
                node_iterator->next = node_iterator->next->next;
                free(node_iterator->next);
                return 3;
            }
        }
        node_iterator = node_iterator->next;
    }
    return 0;
}

node * update_node(node *list, node *node){
    return 0;
}

int print_list(node *node){

    if(is_empty(node) ){
        return 0;
    }
  
    node_iterator = node->next;
    
    while(node_iterator != NULL){
        printf("\nSymbol: %s Scope: %s Value: %d\n", node_iterator->symbol, node_iterator->scope, node_iterator->value); 
        node_iterator = node_iterator->next;
    }
    return 1;
}

