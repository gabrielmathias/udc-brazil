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
%left T_PLUS T_MINUS T_SLASH T_CDU_CORE
%left T_MULTIPLY T_DIVIDE T_COLON T_DOUBLE_COLON

%type<line> line
%type<line> lines
%type<cdu> 	cdu_expression
%type<partial> partial_expression
%type<txt> text_expression

%start lines

%%

lines:
  line lines	 																	{ printf("#\t newline1\n"); }
	| T_QUIT 																			{ printf("bye!\n"); exit(0); }
;

line:
	cdu_expression 											  				{ printf("#\tCDU_EXPRESSION %s\n", $1); }
	| cdu_expression T_SLASH partial_expression			 { printf("#\tCDU_EXPRESSION SLASH PARTIAL EXPRESSION \n"); }
  | cdu_expression T_SPACE text_expression 			 	 { printf("#\tCDU_EXPRESSION WITH TEXT EXPRESSION \n"); }
  | cdu_expression T_ARROW refs_expression 		  		 { printf("#\tCDU_EXPRESSION WITH COLON \n"); }
  | cdu_expression T_DOUBLE_COLON cdu_expression 		  { printf("#\tCDU_EXPRESSION WITH COLON \n"); }
;

refs_expression:
	cdu_expression			{ printf ("#\tREF_EXPRESSION <REF>%s\n",$1); }
	| cdu_expression refs_expression 	{ printf ("#\tREF_EXPRESSION2 <REF>%s\n",$1); }
;

text_expression:
   T_OTHER_TEXT															{ printf(" <> %s\n", $1); }
;
cdu_expression:
	 T_CDU_CORE																{ printf("<001>%s\n",$1); }
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
