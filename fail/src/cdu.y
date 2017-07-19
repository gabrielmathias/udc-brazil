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
%token T_CDU_CORDINATION
%token<das> T_CDU_DAS
%token<ext> T_CDU_EXT
%token<cdu> T_CDU_CORE
%token T_ARROW 
%token T_EXAMPLE T_END_EXAMPLE
%token T_NEWLINE T_QUIT T_SPACE T_SLASH
%token<txt> T_OTHER_TEXT
%left T_CDU_CORE T_ARROW

%type<line> line
%type<line> lines
%type<cdu> line_01
%type<cdu> line_09
%type<cdu> cdu_01
%type<cdu> cdu_09
%type<txt> example
%type<txt> description
%type<cdu> refs_expression

%start lines

%%

lines:
  	line lines	 									{ printf("\n#-------------------------------------------------\n"); }
	| T_QUIT 										{ printf("bye!\n"); exit(0); }
;

line:
	line_01 							  			{ /* printf("\n#\tCDU_LINE\n") */; }
  	| T_ARROW T_ARROW refs_expression 		 				{ printf("\n#\tREF_EXPRESSION \n"); }
;


line_01:
	 
	 cdu_01 description								{  /* printf("\n#LINE_01\n") */;}
;

cdu_01:
	T_CDU_CORE 										{ printf("\n<01>%s",$1); printf("</01>"); }
;

description:
	T_OTHER_TEXT										{ printf ("\n<02>%s",$1); }
;

refs_expression:
	line_09											{ printf ("\n\n<09.1>%s</>\n",$1); }
	| line_09 more_text								{ printf ("\n\n<09.1>%s</>\n",$1); }
;

line_09:
	cdu_09 more_text								{ printf("\n<09>%s\n",$1);  }
;

cdu_09:
	T_CDU_CORE 										{ printf("\n<09>%s\n",$1); }
;

more_text:
	example											{ printf("EXAMPLE");}
	| T_OTHER_TEXT									{ printf("s");  }
	| T_OTHER_TEXT more_text 						{ printf("s");  }
;

example:
	T_EXAMPLE more_text T_END_EXAMPLE               { printf("<06>");  }
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
