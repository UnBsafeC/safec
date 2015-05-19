#include "global.h"
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

void add_symbol_to_table(char *symbol, int flag_atribution, int value);

void check_uninitialized_vars(node *list, int atribution, char *symbol, int symbol_value);

void set_scope(char *symbol);

int check_scope_vulnerability(node *list, char *scope, char *symbol);

void check_implicite_division_by_zero(node *list, char * variable);

