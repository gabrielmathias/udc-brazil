%option noyywrap

%{
#include <stdio.h>
#include <string.h>
#include <ctype.h>

#define YY_DECL int yylex()

#include "cdu.tab.h"

char * trim(char * s) {
    int l = strlen(s);

    while(isspace(s[l - 1])) --l;
    while(* s && isspace(* s)) ++s, --l;

    return strndup(s, l);
}

%}

%%
^([0-9]+([A-Z0-9\.]+))        { yylval.cdu = strdup(yytext); return T_CDU_CORE;}

"→"                     {return T_ARROW; }



[. \t\na-zA-Z0-9]{0,5000}[\n]                {  yylval.txt = strdup (yytext) ; return T_OTHER_TEXT; }

%%
