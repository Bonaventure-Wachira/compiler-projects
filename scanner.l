%{
#include <string>
#include <vector>

using namespace std;

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
punc		[\(\),.:;]
real_lit	{int}(\.{digit}+([eE][-+]?{digit}+)?)?|\.{digit}+([eE][-+]?{digit}+)?
%%

{ws}		{ }
{comment}	{ nextLine();}
{line}		{ nextLine();}
"<"		{ return(RELOP); }
">"		{ return(RELOP); }
"+"		{ return(ADDOP); }
"-"		{ return(ADDOP); }
"*"		{ return(MULOP); }
"="		{ return(ASSIGN); }
begin		{ return(BEGIN_); }
boolean		{ return(BOOLEAN); }
end		{ return(END); }
endreduce	{ return(ENDREDUCE); }
function	{ return(FUNCTION); }
integer		{ return(INTEGER); }
`is      { return(IS); }
reduce		{ return REDUCE; }
returns		{ return(RETURNS); }
and		{ return(ANDOP); }
{id}		{ return(IDENTIFIER);}
{int}		{ return(INT_LITERAL); }
{real_lit}	{ return(REAL_LITERAL); }
{punc}		{ return(yytext[0]); }
.		{ appendError(LEXICAL, yytext); }

%%

