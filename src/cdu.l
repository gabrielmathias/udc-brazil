%option noyywrap

%{
#include <stdio.h>

#define YY_DECL int yylex()

#include "cdu.tab.h"

%}

%%

[ \t]	; // ignore all whitespace
[0-9]+	{return T_CDU;}
(\.[0-9]+(\.[0-9]+)?)?(\*.+)?	{return T_CDU_PARTIAL;}
\n			{return T_NEWLINE;}
[a-zA-Z `'"!?.-]+	{return T_TEXT;}
"::"		{return T_DOUBLE_COLON;}
":"		{return T_COLON;}
"+"		{return T_PLUS;}
"→"		{return T_ARROW;}
"-"		{return T_MINUS;}
"/"		{return T_DIVIDE;}
"("		{return T_LEFT;}
")"		{return T_RIGHT;}
"exit"		{return T_QUIT;}
"quit"		{return T_QUIT;}

%%
