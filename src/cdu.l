%option noyywrap

%{
#include <stdio.h>
#include <string.h>

#define YY_DECL int yylex()

#include "cdu.tab.h"

%}

%%

"\n\n"                          { return T_QUIT; }
[\n\t]		            ;
[0-9]+([’]?[^\x{2192} \t\n])+        {yylval.cdu = strdup(yytext); return T_CDU_CORE;}
"::"		                    { return T_DOUBLE_COLON; }
":"	  	                        { return T_COLON; }
"+"	  	                        { return T_PLUS; }
[\x{2192}]                        { return T_ARROW; }
"-"                             { return T_MINUS; }
"/"	  	                        { return T_SLASH; }
"("	  	                        { return T_PLEFT; }
")"	  	                        { return T_PRIGHT; }
[\w]+[\w\d]*[\n]                { yylval.txt = strdup(yytext); return T_OTHER_TEXT; }
%%
