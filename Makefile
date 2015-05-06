safec: safec.l safec.y
	bison -d safec.y
	mv safec.tab.h sintatico.h
	mv safec.tab.c sintatico.c
	flex safec.l
	mv lex.yy.c lexico.c
	gcc -o safec -lm sintatico.c lexico.c symbol_table.c parser.c

test: safec
	tests/run_all
	gcc -o run_cunit_tests test_symbol_table.c -lcunit
	./run_cunit_tests

clean:
	rm lexico.* sintatico.* safec run_cunit_tests
