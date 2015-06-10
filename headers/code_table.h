#ifndef CODE_TABLE
#define CODE_TABLE

#include <stdio.h>
#include <stdlib.h>

#define TRUE 1
#define FALSE 0

typedef struct Line{
    char content[200];
    struct Line *next;
    struct Line *prev;
}line;

line *code_table;
int line_number;

line *create_code_table();
int code_table_is_empty(line *head_code_table );
void insert_line(line *head_code_table, char *content, int line);
line *find_line(line *head_code_table, int number);
int write_code_table(line *code_table);
void fill_code_table(line * code_table);

#endif
