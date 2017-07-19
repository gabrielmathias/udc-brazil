%option noyywrap

%{
#include <stdio.h>
#include <string.h>
#include <ctype.h>

#define YY_DECL int yylex()

#include "cdu.tab.h"

char * check(char * sent) {
    int l = strlen(sent);

    while(isspace(sent[l - 1])) --l;
    while(* sent && isspace(* sent)) ++sent, --l;

    char *pch = strstr(sent, "xemplo");
    if( pch ) {
        return "<06>";
    } 

    return strndup(sent, l);
}

%}

%%

[\t] ;
"Exemplo"            { yylval.txt = "\n<06>"; return T_EXAMPLE; }
"Exemplos"           { yylval.txt = "\n<06>"; return T_EXAMPLE; }
"Exemplo(s)"         { yylval.txt = "\n<06>"; return T_EXAMPLE; }
"exemplo"            { yylval.txt = "\n<06>"; return T_EXAMPLE; }
"exemplos"           { yylval.txt = "\n<06>"; return T_EXAMPLE; }
"exemplo(s)"         { yylval.txt = "\n<06>"; return T_EXAMPLE; }
"</EXEMPLO>"         { return T_END_EXAMPLE; }

"->"                     {return T_ARROW; }

[0-9]+([A-Z0-9\.]+)        { yylval.cdu = strdup(yytext); return T_CDU_CORE;}

[[:alnum:]]+           {  yylval.txt = strdup (yytext) ; return T_OTHER_TEXT; }

%%
