#ifndef SYMBOL_TABLE
#define SYMBOL_TABLE

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define TRUE 1
#define FALSE 0
typedef struct Node{

    char *symbol;
    struct Node *next;
    int inicialized;
    int value;
    int id;
}node;

node *list;

node *node_iterator;
node *current_node;
node *next_node;

void create_list(node *list);

int is_empty(node *list_node );

void insert_symbol(node *list_node);

node *find_symbol(node *node, char symbol[40]);

void destroy_list(node *node);

#endif
