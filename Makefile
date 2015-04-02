safec: safec.l safec.y
	bison -d safec.y
	mv safec.tab.h sintatico.h
	mv safec.tab.c sintatico.c
	flex safec.l
	mv lex.yy.c lexico.c
	gcc -o safec -lm sintatico.c lexico.c

clean:
	rm lexico.* sintatico.* safec
