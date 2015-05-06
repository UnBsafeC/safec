#include "CUnit/CUnit.h"
#include "CUnit/Basic.h"
//#include "CUnit/Automated.h"
//#include "CUnit/Console.h"

#include "symbol_table.c"

#include <stdio.h>  // for printf



extern node *list;
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

// When I need create one list, i call create_list()
// and create_list() should return one node of list
void test_create_list(void) {

  list = create_list();
  CU_ASSERT_EQUAL( list->next, NULL);
}



// When I need check if list is empty
// and is_empty() should return 1
void test_list_is_empty(void) {

  list = create_list();

  CU_ASSERT_EQUAL( is_empty(list), 1);
  CU_ASSERT_NOT_EQUAL( is_empty(list), 0);

}

// When I need i need insert one symbol, i call insert_symbol()
// and check with find_symbol should return one node of list
void test_insert_symbol(void) {

  list = create_list();
  node *new_node = (node *) malloc(sizeof(node));
  new_node->symbol = "test";
  insert_symbol(list,new_node);
  node *element = find_symbol(list,"test");
  CU_ASSERT_STRING_EQUAL(element->symbol, "test");
  CU_ASSERT_NOT_EQUAL(element, NULL);

}


// When I need i need insert one symbol, i call insert_symbol()
// and check with find_symbol should return one node of list
void test_destroy_list(void) {

  list = create_list();
  node *new_node = (node *) malloc(sizeof(node));
  new_node->symbol = "test";
  insert_symbol(list,new_node);


  node *new_node_2 = (node *) malloc(sizeof(node));
  new_node_2->symbol = "testa";
  insert_symbol(list,new_node_2);

  node *new_node_3 = (node *) malloc(sizeof(node));
  new_node_3->symbol = "testi";
  insert_symbol(list,new_node_3);

  node *element_1 = find_symbol(list,"test");
  node *element_2 = find_symbol(list,"testa");
  node *element_3 = find_symbol(list,"testi");
  node *element_4 = find_symbol(list,"not-found");

  CU_ASSERT_STRING_EQUAL(element_1->symbol, "test");
  CU_ASSERT_STRING_EQUAL(element_2->symbol, "testa");
  CU_ASSERT_STRING_EQUAL(element_3->symbol, "testi");
  CU_ASSERT_EQUAL(element_4, NULL);
  CU_ASSERT_NOT_EQUAL(element_1, NULL);
  CU_ASSERT_NOT_EQUAL(element_2, NULL);
  CU_ASSERT_NOT_EQUAL(element_3, NULL);


}

// When I need i need destroy the list.
void test_find_symbol(void) {

  list = create_list();
  node *new_node = (node *) malloc(sizeof(node));
  new_node->symbol = "test";
  insert_symbol(list,new_node);


  node *new_node_2 = (node *) malloc(sizeof(node));
  new_node_2->symbol = "testa";
  insert_symbol(list,new_node_2);

  node *new_node_3 = (node *) malloc(sizeof(node));
  new_node_3->symbol = "testi";
  insert_symbol(list,new_node_3);

  node *element_1 = find_symbol(list,"test");
  node *element_2 = find_symbol(list,"testa");
  node *element_3 = find_symbol(list,"testi");
  node *element_4 = find_symbol(list,"not-found");

  CU_ASSERT_STRING_EQUAL(element_1->symbol, "test");
  CU_ASSERT_STRING_EQUAL(element_2->symbol, "testa");
  CU_ASSERT_STRING_EQUAL(element_3->symbol, "testi");
  CU_ASSERT_EQUAL(element_4, NULL);

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
   if ( (NULL == CU_add_test(pSuite, "Create list", test_create_list)) ||
        (NULL == CU_add_test(pSuite, "List is empty", test_list_is_empty)) ||
        (NULL == CU_add_test(pSuite, "Insert Symbol", test_insert_symbol)) ||
        (NULL == CU_add_test(pSuite, "Destroy List", test_destroy_list)) ||
        (NULL == CU_add_test(pSuite, "Find Symbols", test_find_symbol))
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