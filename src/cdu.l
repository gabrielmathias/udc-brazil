%option noyywrap

%{
#include <stdio.h>
#include <string.h>

#define YY_DECL int yylex()

#include "cdu.tab.h"

%}

%%

[ \n\t]		            ;
[0-9]+([0-9]+(\.[0-9]+)*)*		   {yylval.cdu = strdup(yytext); return T_CDU_CORE;}
[\w\d]+                   		   {yylval.partial = strdup(yytext); return T_CDU_PARTIAL;}
\*.+			                       {yylval.ext = strdup(yytext); return T_CDU_EXT;}
[a-zA-Z][0-9a-zA-Z]+	           {yylval.das = strdup(yytext); return T_CDU_DAS;}
[\w\d\s]+    	                   {yylval.txt = strdup(yytext); return T_OTHER_TEXT;}
"::"		{return T_DOUBLE_COLON;}
":"	  	{return T_COLON;}
"+"	  	{return T_PLUS;}
"→"	  	{return T_ARROW;}
"-"	  	{return T_MINUS;}
"/"	  	{return T_SLASH;}
"("	  	{return T_PLEFT;}
")"	  	{return T_PRIGHT;}
. { return yytext[0]; }
%%
