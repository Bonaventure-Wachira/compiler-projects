

/* This file contains flex input file */

%{
#include <string>
#include <vector>

using namespace std;

#include "listing.h"
#include "tokens.h"

%}

%option noyywrap

ws      [ \t\r]+
comment     (--.*\n)|\/\/[^\n]*\n
line        [\n]
id      [A-Za-z](_?[A-Za-z0-9])*_?
digit       [0-9]
int     {digit}+
real    {digit}+\.{digit}*(((E|e)(\+|-)?{digit}+)|\.)?
punc        [\(\),:;]
%%

{ws}        { ECHO; }
{comment}   { ECHO; nextLine();}
{line}      { ECHO; nextLine();}
"=>"     { ECHO; return(ARROW); }
"="      { ECHO; return(RELOP); }
"/="     { ECHO; return(RELOP); }
">"      { ECHO; return(RELOP); }
">="     { ECHO; return(RELOP); }
"<="     { ECHO; return(RELOP); }
"+"      { ECHO; return(ADDOP); }
"-"      { ECHO; return(ADDOP); }
"*"      { ECHO; return(MULOP); }
"/"      { ECHO; return(MULOP); }
"rem"    { ECHO; return(REMOP); }
"**"     { ECHO; return(EXPOP); }
"or"     { ECHO; return(OROP); }
"not"    { ECHO; return(NOTOP); }
"case"       { ECHO; return(CASE); }
"else"       { ECHO; return(ELSE); }
"endcase"    { ECHO; return(ENDCASE); }
"endif"      { ECHO; return(ENDIF); }
"if"     { ECHO; return(IF); }
"others"     { ECHO; return(OTHERS); }
"real"       { ECHO; return(REAL); }
"then"       { ECHO; return(THEN); }
"when"       { ECHO; return(WHEN); }
"true"       { ECHO; return(BOOL_LITERAL); }
"false"      { ECHO; return(BOOL_LITERAL); }
begin       { ECHO; return(BEGIN_); }
boolean     { ECHO; return(BOOLEAN); }
end     { ECHO; return(END); }
endreduce   { ECHO; return(ENDREDUCE); }
function    { ECHO; return(FUNCTION); }
integer     { ECHO; return(INTEGER); }
is      { ECHO; return(IS); }
reduce      { ECHO; return(REDUCE); }
returns     { ECHO; return(RETURNS); }
and     { ECHO; return(ANDOP); }
{id}        { ECHO; return(IDENTIFIER);}
{int}        { ECHO; return(INT_LITERAL); }
{real}       { ECHO; return(REAL_LITERAL); }
{punc}       { ECHO; return(yytext[0]); }
.        { ECHO; appendError(LEXICAL, yytext); }

%%
