%option noyywrap

%{
#include <stdio.h>
#include <string.h>

#define YY_DECL int yylex()

#include "cdu.tab.h"

%}

%%

[\n\t]		            ;
[0-9]+([\:]{0,2}[\.]?[0-9]+)*    {yylval.cdu = strdup(yytext); return T_CDU_CORE;}
"::"		                        { return T_DOUBLE_COLON; }
":"	  	                        { return T_COLON; }
"+"	  	                        { return T_PLUS; }
"→"                             { return T_ARROW; }
"-"                             { return T_MINUS; }
"/"	  	                        { return T_SLASH; }
"("	  	                        { return T_PLEFT; }
")"	  	                        { return T_PRIGHT; }
[\w]+[\w\d]*[\n]         { return T_OTHER_TEXT; }
%%
