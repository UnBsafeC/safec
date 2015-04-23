%{
#include "global.h"
#include <stdlib.h>
#include "sintatico.h"
int line_number=1;
extern node *list;
%}

white [ \t]+
digit [0-9]
integer {digit}+
real {integer}("."{integer})?

includes .*#include.*
main .*main.*

%%

{white} { /* We ignore white characters */ }
{includes} {return(INCLUDES); }
{main} {return(MAIN); }
{real}  { yylval = atof(yytext); return(NUMBER); }

"sqrt"  { return(SQRT); }
"pow"   { return(POW); }
","     { return(COMMA); }
"*"     { return(TIMES); }
"/"     { return(DIVIDE); }
"-"     { return(MINUS); }
"+"     { return(PLUS); }
"("     { return(LEFT_PARENTHESIS); }
")"     { return(RIGHT_PARENTHESIS); }
"{"     { return(START_FILE); }
"}"     { return(END_FILE); }
"\n"    { return(END); }

%%

yywrap(){
  return 1;
}
