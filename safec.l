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

%%

{white} { /* We ignore white characters */ }
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
"\n"    { return(END); }
"{"    { return(START_FILE); }
"}"    { return(END_FILE); }

%%

yywrap(){
  return 1;
}
