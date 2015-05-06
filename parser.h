#include "global.h"
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

void add_symbol_to_table(char *symbol, int flag_atribution, int value);

int check_vulnerability(node *list, char *symbol, int flag_atribution);

void check_uninitialized_vars(node *list, int atribution, char *symbol, int symbol_value);

void set_scope(char *symbol);
