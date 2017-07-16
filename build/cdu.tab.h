/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_CDU_TAB_H_INCLUDED
# define YY_YY_CDU_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    T_INT = 258,
    T_CDU_PARTIAL = 259,
    T_CDU_CORDINATION = 260,
    T_CDU_DAS = 261,
    T_CDU_EXT = 262,
    T_CDU_CORE = 263,
    T_ARROW = 264,
    T_PLUS = 265,
    T_MINUS = 266,
    T_MULTIPLY = 267,
    T_PLEFT = 268,
    T_PRIGHT = 269,
    T_COLON = 270,
    T_DOUBLE_COLON = 271,
    T_NEWLINE = 272,
    T_QUIT = 273,
    T_SPACE = 274,
    T_SLASH = 275,
    T_OTHER_TEXT = 276,
    T_DIVIDE = 277
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 13 "../src/cdu.y" /* yacc.c:1915  */

	int ival;
	float fval;
  char * cdu;
  char * partial;
  char * das;
  char * ext;
  char * txt;
  char * line;

#line 88 "cdu.tab.h" /* yacc.c:1915  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_CDU_TAB_H_INCLUDED  */
