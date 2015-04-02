%{
#include "global.h"
#include "sintatico.h"
#include <stdlib.h>
%}
white [ \t]+
digit [0-9]
integer {digit}+
exponant [eE][+-]?{integer}

%%

{white} { /* We ignore white characters */ }
{digit} { 
  yylval = atof(yytext);
  return(NUMBER); 
}

"/" return(DIVIDE);
"\n" return(END);

%%

yywrap () {
return 0;
}
