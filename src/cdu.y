%{

#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern int yyparse();
extern FILE* yyin;

void yyerror(const char* s);
%}

%union {
	int ival;
	float fval;
  char * cdu;
  char * partial;
  char * das;
  char * ext;
  char * txt;
  char * line;
}

%token<ival> T_INT
%token<partial> T_CDU_PARTIAL
%token T_CDU_CORDINATION
%token<das> T_CDU_DAS
%token<ext> T_CDU_EXT
%token<cdu> T_CDU_CORE
%token T_ARROW T_PLUS T_MINUS T_MULTIPLY T_PLEFT T_PRIGHT T_COLON T_DOUBLE_COLON
%token T_NEWLINE T_QUIT T_SPACE T_SLASH
%token<txt> T_OTHER_TEXT
%left T_CDU_CORE

%type<line> line
%type<line> lines
%type<cdu> line_01
%type<cdu> ref_cdu
%type<partial> partial_expression
%type<txt> text_expression
%type<txt> refs_expression

%start lines

%%

lines:
  line lines	 																	{ printf("#\t newline1\n"); }
	| T_QUIT 																			{ printf("bye!\n"); exit(0); }
;

line:
	line_01 											  				{ printf("\n#\tCDU_LINE %s\n", $1); }
  | T_ARROW refs_expression 		  					 { printf("\n#\tREF_EXPRESSION \n"); }
;


line_01:
	 T_CDU_CORE 						{ printf("\n<01>%s\n",$1); free($1);}
	 | T_CDU_CORE T_OTHER_TEXT						{ printf("\n<001>%s\n<02>%s\n",$1,$2); free($1);}
	 | T_CDU_CORE T_OTHER_TEXT more_text			{ printf("\n<01>%s\n<02>%s\n",$1,$2); free($1);}
;

more_text:
	T_OTHER_TEXT									{ printf(">:1:> %s",$1); free ($1); }
	| T_OTHER_TEXT	more_text 						{ printf(">:2:> %s",$1); free ($1); }
;

refs_expression:
	ref_cdu											{ printf ("\n\n<09.1>%s</>\n",$1); }
	| ref_cdu refs_expression						{ printf ("\n\n<09.1>%s</>\n",$1); }
	| T_OTHER_TEXT refs_expression 					{ printf ("\n\n<09.2>%s</>\n",$1); }
;

ref_cdu:
	T_CDU_CORE T_OTHER_TEXT							{ printf("\n\n--------------------------------------------------------------------------\n<09>%s %s\n",$1,$2); free($1);free($2);}
;

text_expression:
   T_OTHER_TEXT															{ printf("\n<02> %s</02>\n", $1); }
   |T_OTHER_TEXT	text_expression											{ printf("\n<02> %s</02>\n", $1); }
;

partial_expression:
	 T_CDU_PARTIAL														{ printf("\tCDU_PARTIAL %s\n",$1); }
;
%%

int main() {
	int tok;
	yyin = stdin;

	do {
		yyparse();
		tok = yylex();
	} while(!feof(yyin));

	return 0;
}

void yyerror(const char* s) {
	fprintf(stderr, "#Parse error: %s\n", s);
}
