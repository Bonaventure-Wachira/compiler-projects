/* This file contains flex input file */

%{
#include <string>

using namespace std;

#include "values.h"
#include "listing.h"
#include "tokens.h"

%}

%option noyywrap

ws		[ \t\r]+
comment		\-\-.*\n
line		[\n]
id		[A-Za-z][A-Za-z0-9]*
digit		[0-9]
int		{digit}+
punc		[\(\),:;]
real		[-+]?{digit}*\.{digit}+([Ee][-+]?{digit}+)?|[-+]?{digit}+\.{digit}*([Ee][-+]?{digit}+)?|[-+]?{digit}+[Ee][-+]?{digit}+
bool    true|false
real_kw      real
real_literal [-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?




%%

{ws}		{ ECHO; }
{comment}	{ ECHO; nextLine();}
{line}		{ ECHO; nextLine();}
"<"		{ ECHO; yylval.oper = LESS; return(RELOP); }
"+"		{ ECHO; yylval.oper = ADD; return(ADDOP); }
"*"		{ ECHO; yylval.oper = MULTIPLY; return(MULOP); }
"-"         { ECHO; yylval.oper = SUBTRACT; return(ADDOP); }
"/"         { ECHO; yylval.oper = DIVIDE; return(MULOP); }
"%"         { ECHO; yylval.oper = MODULUS; return(MULOP); }
"<"         { ECHO; yylval.oper = LESS; return(RELOP); }
">"         { ECHO; yylval.oper = GREATER; return(RELOP); }
"<="        { ECHO; yylval.oper = LESS_EQUAL; return(RELOP); }
">="        { ECHO; yylval.oper = GREATER_EQUAL; return(RELOP); }
"="         { ECHO; yylval.oper = EQUAL; return(RELOP); }
"/="        { ECHO; yylval.oper = NOT_EQUAL; return(RELOP); }
"and"       { ECHO; return(ANDOP); }
"or"        { ECHO; return(OROP); }
"not"        { ECHO; return(NOTOP); }




begin		{ ECHO; return(BEGIN_); }
boolean		{ ECHO; return(BOOLEAN); }
end		{ ECHO; return(END); }
endreduce	{ ECHO; return(ENDREDUCE); }
function	{ ECHO; return(FUNCTION); }
integer		{ ECHO; return(INTEGER); }
is		{ ECHO; return(IS); }
reduce		{ ECHO; return(REDUCE); }
returns		{ ECHO; return(RETURNS); }
and		{ ECHO; return(ANDOP); }
if          { ECHO; return(IF); }
then        { ECHO; return(THEN); }
else        { ECHO; return(ELSE); }
endif       { ECHO; return(ENDIF); }


{real}		{ ECHO; yylval.value = atof(yytext); return(REAL_LITERAL); }
{real_literal} { ECHO; yylval.value = atof(yytext); return(REAL_LITERAL); }
{real_kw}    { ECHO; return(REAL); }
{bool}       { ECHO; yylval.value = strcmp(yytext, "true") == 0 ? 1 : 0; return(BOOLEAN_LITERAL); }
{id}		{ ECHO; yylval.iden = (CharPtr)malloc(yyleng + 1); 
			strcpy(yylval.iden, yytext); return(IDENTIFIER);}
{int}		{ ECHO; yylval.value = atoi(yytext); return(INT_LITERAL); }
{int}		{ ECHO; yylval.value = atoi(yytext); return(INT_LITERAL); }
{punc}		{ ECHO; return(yytext[0]); }
.		{ ECHO; appendError(LEXICAL, yytext); }

%%