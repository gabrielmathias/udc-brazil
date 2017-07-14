%option noyywrap

%{
#include <stdio.h>

#define YY_DECL int yylex()

#include "cdu.tab.h"

%}

%%

[ \t]	; // ignore all whitespace
[0-9]+(\.[0-9]+(\.[0-9])?)?	{return T_CDU;}
\n		{return T_NEWLINE;}
"+"		{return T_PLUS;}
"-"		{return T_MINUS;}
"*"		{return T_MULTIPLY;}
"/"		{return T_DIVIDE;}
"("		{return T_LEFT;}
")"		{return T_RIGHT;}
"exit"		{return T_QUIT;}
"quit"		{return T_QUIT;}

%%
