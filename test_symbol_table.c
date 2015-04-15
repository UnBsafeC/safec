/* Arquivo de teste da tabela de simbolos*/
#include "symbol_table.h"

int main(){

    node *list = (node *) malloc(sizeof(node));
    node *my_symbol;
    node *my_symbol_2;
    if (!list) {
      puts("Sem memoria disponivel");
      exit(1);
    }

    create_list(list);
    insert_symbol(list,"haha");
    my_symbol = find_symbol(list,"haha");
    my_symbol_2 = find_symbol(list,"hehe");


    destroy_list(list);

    return 0;
}
