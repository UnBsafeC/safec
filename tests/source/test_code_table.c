#include "CUnit/CUnit.h"
#include "CUnit/Basic.h"

#include "code_table.c"

#include <string.h>

extern line *code_table;
/* Test Suite setup and cleanup functions: */

int init_suite(void) { return 0; }
int clean_suite(void) { return 0; }

/************* Test case functions ****************/

void test_case_sample(void)
{
    CU_ASSERT(CU_TRUE);
    CU_ASSERT_NOT_EQUAL(2, -1);
    CU_ASSERT_STRING_EQUAL("string #1", "string #1");
    CU_ASSERT_STRING_NOT_EQUAL("string #1", "string #2");

    CU_ASSERT(CU_FALSE);
    CU_ASSERT_EQUAL(2, 3);
    CU_ASSERT_STRING_NOT_EQUAL("string #1", "string #1");
    CU_ASSERT_STRING_EQUAL("string #1", "string #2");
}

void test_create_code_table(void)
{
    code_table = create_code_table();

    CU_ASSERT_NOT_EQUAL(code_table, NULL);
    CU_ASSERT_EQUAL(code_table->next, NULL);
    CU_ASSERT_EQUAL(code_table->prev, NULL);
}

void test_code_table_is_empty(void)
{
    code_table = create_code_table();

    CU_ASSERT_EQUAL(code_table_is_empty(code_table), 1);
    CU_ASSERT_NOT_EQUAL(code_table_is_empty(code_table), 0);
}

void test_insert_sequential_line(void)
{
    line *line, *line2, *line3;
    code_table = create_code_table();

    insert_line(code_table, "test", 1);
    line = find_line(code_table, 1);
    CU_ASSERT_STRING_EQUAL(line->content, "test");
    CU_ASSERT_NOT_EQUAL(line, NULL);

    insert_line(code_table, "test2", 2);
    line2 = find_line(code_table, 2);
    CU_ASSERT_STRING_EQUAL(line2->content, "test2");
    CU_ASSERT_NOT_EQUAL(line2, NULL);

    insert_line(code_table, "test3", 3);
    line3 = find_line(code_table, 3);
    CU_ASSERT_STRING_EQUAL(line3->content, "test3");
    CU_ASSERT_NOT_EQUAL(line3, NULL);
}

void test_insert_in_middle_line(void)
{
    line *line;
    code_table = create_code_table();

    insert_line(code_table, "test", 1);
    insert_line(code_table, "test2", 2);
    insert_line(code_table, "test middle", 2);

    line = find_line(code_table, 2);
    CU_ASSERT_STRING_EQUAL(line->content, "test middle");
    CU_ASSERT_NOT_EQUAL(line, NULL);
}

void test_insert_in_first_line(void)
{
    line *line;
    code_table = create_code_table();

    insert_line(code_table, "test", 1);
    insert_line(code_table, "test2", 2);
    insert_line(code_table, "test first", 1);

    line = find_line(code_table, 1);
    CU_ASSERT_STRING_EQUAL(line->content, "test first");
    CU_ASSERT_NOT_EQUAL(line, NULL);
}

void test_find_symbol(void)
{
    code_table = create_code_table();

    insert_line(code_table, "test", 1);
    insert_line(code_table, "test2", 2);
    insert_line(code_table, "test3", 3);

    line *element_1 = find_line(code_table, 1);
    line *element_2 = find_line(code_table, 2);
    line *element_3 = find_line(code_table, 3);
    line *element_4 = find_line(code_table, 4);

    CU_ASSERT_STRING_EQUAL(element_1->content, "test");
    CU_ASSERT_STRING_EQUAL(element_2->content, "test2");
    CU_ASSERT_STRING_EQUAL(element_3->content, "test3");
    CU_ASSERT_EQUAL(element_4, NULL);
}

void test_write_code(void)
{
    code_table = create_code_table();

    insert_line(code_table, "test0", 1);
    insert_line(code_table, "test1", 2);
    insert_line(code_table, "test2", 3);

    CU_ASSERT_EQUAL(write_code_table(code_table),1);
}

void test_write_code_without_table(void)
{
  insert_line(code_table, "test0", 1);
  insert_line(code_table, "test1", 2);
  insert_line(code_table, "test2", 3);

  CU_ASSERT_EQUAL(write_code_table(code_table),1);
}

void test_write_code_table_sequential(void)
{
    code_table = create_code_table();
    int status=0;
    char line_content[200];
    // Refactor, we need work in the best way to implement this.

    insert_line(code_table, "test0", 1);
    insert_line(code_table, "test1", 2);
    insert_line(code_table, "test2", 3);

    write_code_table(code_table);
    FILE *file = fopen("output/safec.c","r+");

    while (fgets (line_content, 200, file) != NULL) {
        if(strcmp(line_content,"test0\n") == 0 ||
           strcmp(line_content,"test1\n") == 0 ||
           strcmp(line_content,"test2\n") == 0 )
            status++;
    }

    CU_ASSERT_EQUAL(status,2);

    fclose(file);
}

/************* Test Runner Code goes here **************/

int main ( void )
{
   CU_pSuite pSuite = NULL;

   /* initialize the CUnit test registry */
   if ( CUE_SUCCESS != CU_initialize_registry() )
      return CU_get_error();

   /* add a suite to the registry */
   pSuite = CU_add_suite( "max_test_suite", init_suite, clean_suite );
   if ( NULL == pSuite ) {
      CU_cleanup_registry();
      return CU_get_error();
   }

   /* add the tests to the suite */
   if ( (NULL == CU_add_test(pSuite, "Create code table", test_create_code_table)) ||
        (NULL == CU_add_test(pSuite, "Code table is empty", test_code_table_is_empty)) ||
        (NULL == CU_add_test(pSuite, "Insert sequential line in code table", test_insert_sequential_line)) ||
        (NULL == CU_add_test(pSuite, "Insert line in middle of code table", test_insert_in_middle_line)) ||
        (NULL == CU_add_test(pSuite, "Insert line in begin of code table", test_insert_in_first_line)) ||
        (NULL == CU_add_test(pSuite, "Find line in code table", test_find_symbol)) ||
        (NULL == CU_add_test(pSuite, "write code", test_write_code)) ||
        (NULL == CU_add_test(pSuite, "write code without code table", test_write_code_without_table)) ||
        (NULL == CU_add_test(pSuite, "write code table in file", test_write_code_table_sequential))
      )
   {
      CU_cleanup_registry();
      return CU_get_error();
   }

   // Run all tests using the basic interface
   CU_basic_set_mode(CU_BRM_VERBOSE);
   CU_basic_run_tests();
   printf("\n");
   CU_basic_show_failures(CU_get_failure_list());
   printf("\n\n");
/*
   // Run all tests using the automated interface
   CU_automated_run_tests();
   CU_list_tests_to_file();

   // Run all tests using the console interface
   CU_console_run_tests();
*/
   /* Clean up registry and return */
   CU_cleanup_registry();
   return CU_get_error();
}
