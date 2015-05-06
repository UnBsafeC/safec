%{
#include "global.h"
#include "sintatico.h"
#include <stdlib.h>
#include <stdio.h>
int line_number=1;
extern node *list;
%}

white [ \t]+
digit [0-9]
integer {digit}+
real {integer}("."{integer})?

includes .*#include.*

word [a-z]*


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
"="     { return(EQUALS); }

"("     { return(LEFT_PARENTHESIS); }
")"     { return(RIGHT_PARENTHESIS); }
"{"     { return(START_FILE); }
"}"     { return(END_FILE); }
"\n"    { ++line_number; return(END); }
";"     { return(DOT_COMMA); }


{white} { /* We ignore white characters */ }
{includes} {return(INCLUDES); }
{real}  { yylval.val = atof(yytext); return(NUMBER); }
{word} { yylval.symbol = strndup(yytext,40); return(VARIABLE); }
%%

yywrap(){
  return 1;
}
