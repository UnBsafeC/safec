%{
#include "global.h"
#include "sintatico.h"
#include <stdlib.h>
#include <stdio.h>
extern node *list;
int line_number=1;
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

","     { return(','); }
"*"     { return('*'); }
"/"     { return('/'); }
"-"     { return('-'); }
"+"     { return('+'); }
"="     { return('='); }

"("     { return('('); }
")"     { return(')'); }
"{"     { return('{'); }
"}"     { return('}'); }
"\n"    { ++line_number; return(END); }
";"     { return(';'); }


{white} { /* We ignore white characters */ }
{includes} {return(INCLUDES); }
{real}  { yylval.val = atof(yytext); return(NUMBER); }
{word} { yylval.symbol = strndup(yytext,40); return(IDENTIFIER); }
%%

yywrap(){
  return 1;
}
