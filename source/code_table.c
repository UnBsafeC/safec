#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "code_table.h"

#define TRUE 1
#define FALSE 0

extern int line_number;

line * head;

line *create_code_table()
{
    line *table = (line *) malloc(sizeof(line));
    table->next = NULL;
    table->prev = NULL;
    return table;
}

int code_table_is_empty(line *head)
{
    if  (head->prev == NULL && head->next == NULL)
        return TRUE;

    return FALSE;
}

void first_code_table_update(line *code_table, char line_content[40] )
{

    line * tmp = (line *) malloc(sizeof(line));
    strcpy(tmp->content, line_content);

    if(code_table_is_empty(code_table))
    {
        code_table->next = tmp;
        tmp->prev = code_table;
        tmp->next = NULL;
    }
    else
    {
        line * iterator = (line *) malloc(sizeof(line));
        iterator->next = code_table;
        line * last;

        while(1)
        {
            if(iterator->next == NULL)
            {
                last = iterator;
                break;
            }

            iterator = iterator->next;
        }


        last->next = tmp;
        tmp->prev = last;
        tmp->next = NULL;
    }
}


void insert_line(line *head, char content[40], int number)
{

    line *new_line = (line *) malloc(sizeof(line));

    if(!new_line)
    {
        printf("Cannot allocate memory to another Line\n");
        exit -1;
    }

    strcpy(new_line->content, content);

    if(code_table_is_empty(head))
    {
        head->next = new_line;
        new_line->prev = head;
        new_line->next = NULL;

        return;
    }

    line *prev_line   = find_line(head, number-1);
    line *actual_line = find_line(head, number);
    line *next_line   = find_line(head, number+1);


    if(!prev_line)
    {

        line *temp_line = head->next;

        head->next = new_line;
        new_line->prev = head;

        new_line->next = temp_line;
        temp_line->prev = new_line;

        return;
    }

    if(!next_line)
    {
        prev_line->next = new_line;
        new_line->prev = prev_line;
        new_line->next = actual_line;

        return;
    }

    line *temp_line = prev_line->next;

    prev_line->next = new_line;
    new_line->prev = prev_line;

    new_line->next = temp_line;
    temp_line->prev = new_line;
    line_number++;
}

line *find_line(line *head, int number)
{
    if(!head)
        return NULL;

    if(number == 0)
        return NULL;

    line *next = head->next;
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

/* debug method, use it when necessary */
void print_code_table(line * code_table)
{
    line * iterator = code_table;
    while(iterator->next != NULL)
    {
        printf("%s", iterator->next->content);
        iterator = iterator->next;
    }
}


void fill_code_table(line * code_table)
{
    FILE *final_file;
    char  * line_content;
    size_t len = 0;
    ssize_t read;

    final_file = fopen("output/safec.c", "r");

    int status = 1;

    while((read = getline(&line_content, &len, final_file)) != -1 )
    {
       char tmp_content[40];
       strcpy(tmp_content, line_content);
       first_code_table_update(code_table, tmp_content);
    }
    free(line_content);
}


int write_code_table(line *code_table)
{

    mkdir("output", 0700);
    FILE *file = fopen("output/safec.c","w+");

    if(code_table_is_empty(code_table))
    {
        return 0;
    }

    line *iterator = (line *) malloc(sizeof(line));
    iterator = code_table->next;

    while (iterator != NULL)
    {
        fprintf(file, "%s",iterator->content);
        iterator = iterator->next;
    }

    fclose(file);
    return 1;
}
