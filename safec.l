%{
#include "global.h"
#include <stdlib.h>
#include <stdio.h>
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

declaration_or_attribution [a-z]*(=[1-9]*)?


%%

"sqrt"  { return(SQRT); }
"pow"   { return(POW); }
"int"   { return(INT); }
"float" { return(FLOAT); }

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
";"     { return(DOT_COMMA); }


{white} { /* We ignore white characters */ }
{includes} {return(INCLUDES); }
{main} {return(MAIN); }
{real}  { yylval.val = atof(yytext); return(NUMBER); }
{declaration_or_attribution} { yylval.symbol = strndup(yytext,40); return(VARIABLE); }
%%

yywrap(){
  return 1;
}
