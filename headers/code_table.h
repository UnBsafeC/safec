#ifndef CODE_TABLE
#define CODE_TABLE

#include <stdio.h>
#include <stdlib.h>

#define TRUE 1
#define FALSE 0

typedef struct Line{
    char *content;
    struct Line *next;
    struct Line *prev;
}line;

line *code_table;

line *create_code_table();
int code_table_is_empty(line *head_code_table );
void insert_line(line *head_code_table, char *content, int number);
line *find_line(line *head_code_table, int number);

#endif
