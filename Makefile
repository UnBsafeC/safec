ROOT=headers
SOURCE=source
TEST_ROOT=tests/source
CFLAGS=-I$(ROOT) -lm
CFLAGS2=-I$(SOURCE) -lm
COMPILER=gcc

safec: bison/safec.l bison/safec.y
	bison -d -v bison/safec.y
	mv safec.tab.h headers/sintatico.h
	mv safec.tab.c source/sintatico.c
	flex bison/safec.l
	mv lex.yy.c source/lexico.c
	$(COMPILER) -o  safec source/*.c $(CFLAGS)

test: safec
	tests/run_all
	$(COMPILER) -o run_cunit_tests $(TEST_ROOT)/test_symbol_table.c -lcunit $(CFLAGS2) $(CFLAGS)
	./run_cunit_tests

clean:
	rm source/lexico.c source/sintatico.c headers/sintatico.h safec run_cunit_tests
