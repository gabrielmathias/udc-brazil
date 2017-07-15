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
        char *_01;
        char *_02;
        char *_03;
        char *_04;
}

%token<ival> T_INT
%token T_CDU_PARTIAL
%token T_CDU_CORDINATION
%token T_CDU
%token T_ARROW T_PLUS T_MINUS T_MULTIPLY T_DIVIDE T_LEFT T_RIGHT T_COLON T_DOUBLE_COLON
%token T_NEWLINE T_QUIT
%token T_TEXT
%left T_PLUS T_MINUS
%left T_MULTIPLY T_DIVIDE

%type<ival> expression
%type<fval> mixed_expression

%start calculation

%%

calculation: 
	   | calculation line
;

line: T_NEWLINE
    | cdu_expression T_NEWLINE 			{ printf("\tCDU!!\n"); }
    | cdu_expression T_TEXT T_NEWLINE 		{ printf("\tCDU and TEXT\n"); }
    | mixed_expression T_NEWLINE { printf("\tResult: %f\n", $1);}
    | expression T_NEWLINE { printf("\tResult: %i\n", $1); } 
    | T_QUIT T_NEWLINE { printf("bye!\n"); exit(0); }
;

cdu_expression: T_CDU						{ printf("CDU\n"); }
        | T_CDU T_CDU_PARTIAL					{ printf("CDU WITH PARTIAL\n"); }
	| T_CDU T_CDU_PARTIAL T_DIVIDE T_CDU T_CDU_PARTIAL	{ printf("consecutive extension with full cdu\n"); }
	| T_CDU T_CDU_PARTIAL T_DIVIDE T_CDU_PARTIAL		{ printf("consecutive extension with partial \n"); }
	| T_CDU T_DOUBLE_COLON cdu_expression			{ printf("order fixing with cdu \n"); }
	| T_CDU T_CDU_PARTIAL T_DOUBLE_COLON cdu_expression	{ printf("order fixing with full cdu \n"); }
	| T_CDU T_COLON cdu_expression				{ printf("simple relation with cdu \n"); }
	| T_CDU T_CDU_PARTIAL T_COLON cdu_expression		{ printf("simple relation with full cdu \n"); }
	| cdu_expression T_PLUS cdu_expression			{ printf("coordination \n"); }

mixed_expression: mixed_expression T_PLUS mixed_expression	 { $$ = $1 + $3; }
	  | mixed_expression T_MINUS mixed_expression	 { $$ = $1 - $3; }
	  | mixed_expression T_MULTIPLY mixed_expression { $$ = $1 * $3; }
	  | mixed_expression T_DIVIDE mixed_expression	 { $$ = $1 / $3; }
	  | T_LEFT mixed_expression T_RIGHT		 { $$ = $2; }
	  | expression T_PLUS mixed_expression	 	 { $$ = $1 + $3; }
	  | expression T_MINUS mixed_expression	 	 { $$ = $1 - $3; }
	  | expression T_MULTIPLY mixed_expression 	 { $$ = $1 * $3; }
	  | expression T_DIVIDE mixed_expression	 { $$ = $1 / $3; }
	  | mixed_expression T_PLUS expression	 	 { $$ = $1 + $3; }
	  | mixed_expression T_MINUS expression	 	 { $$ = $1 - $3; }
	  | mixed_expression T_MULTIPLY expression 	 { $$ = $1 * $3; }
	  | mixed_expression T_DIVIDE expression	 { $$ = $1 / $3; }
	  | expression T_DIVIDE expression		 { $$ = $1 / (float)$3; }
;

expression: T_INT				{ $$ = $1; }
	  | expression T_PLUS expression	{ $$ = $1 + $3; }
	  | expression T_MINUS expression	{ $$ = $1 - $3; }
	  | expression T_MULTIPLY expression	{ $$ = $1 * $3; }
	  | T_LEFT expression T_RIGHT		{ $$ = $2; }
;

%%

int main() {
	yyin = stdin;

	do { 
		yyparse();
	} while(!feof(yyin));

	return 0;
}

void yyerror(const char* s) {
	fprintf(stderr, "Parse error: %s\n", s);
	exit(1);
}
