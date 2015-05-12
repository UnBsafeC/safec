#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "code_table.h"

#define TRUE 1
#define FALSE 0

line *create_code_table()
{
    line *table = (line *) malloc(sizeof(line));
    table->next = NULL;
    table->prev = NULL;
    return table;
}

int code_table_is_empty(line *head_code_table)
{
    if(!head_code_table)
        return TRUE;

    if(head_code_table->next == NULL && head_code_table->prev == NULL)
        return TRUE;

    return FALSE;
}

void insert_line(line *head_code_table, char *content, int number)
{
    line *new_line = (line *) malloc(sizeof(line));

    if(!new_line)
    {
        printf("Cannot allocate memory to another Line\n");
        exit -1;
    }

    new_line->content = content;

    if(code_table_is_empty(head_code_table))
    {
        head_code_table->next = new_line;
        new_line->prev = head_code_table;
        new_line->next = NULL;

        return;
    }

    line *prev_line = find_line(head_code_table, number-1);
    line *next_line = find_line(head_code_table, number+1);

    if(!prev_line)
    {

        line *temp_line = head_code_table->next;

        head_code_table->next = new_line;
        new_line->prev = head_code_table;

        new_line->next = temp_line;
        temp_line->prev = new_line;

        return;
    }

    if(!next_line)
    {
        prev_line->next = new_line;
        new_line->prev = prev_line;
        new_line->next = NULL;

        return;
    }

    line *temp_line = prev_line->next;

    prev_line->next = new_line;
    new_line->prev = prev_line;

    new_line->next = temp_line;
    temp_line->prev = new_line;
}

line *find_line(line *head_code_table, int number)
{
    if(!head_code_table)
        return NULL;

    line *next = head_code_table->next;
    int find = FALSE;
    int line = 1;

    while(next != NULL)
    {
        if(line == number)
        {
            find = TRUE;
            return next;
        }

        next = next->next;
        line++;
    }

    if(!find)
        return NULL;
}

int write_code_table(line *head_code_table){

    mkdir("output/", 0700);
    FILE *file = fopen("output/safe_code.c","w+");;

    if(code_table_is_empty(head_code_table))
        return 0;

    line *iterator = (line *) malloc(sizeof(line));
    iterator = head_code_table->next;
    fprintf(file, "//Safe-C Output\n//Now you code is Safe!\n");

    while (iterator != NULL) {

        fprintf(file, "\n%s",iterator->content);
        iterator = iterator->next;
    }
    fprintf(file, "\n//End of file");
    fclose(file);
    return 1;
}
