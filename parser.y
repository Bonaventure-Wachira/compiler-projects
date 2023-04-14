
%{

#include <string>

using namespace std;

#include "listing.h"

int yylex();
void yyerror(const char* message);

%}

%define parse.error verbose

%token IDENTIFIER
%token INT_LITERAL

%token ADDOP MULOP RELOP ANDOP

%token BEGIN_ BOOLEAN END ENDREDUCE FUNCTION INTEGER IS REDUCE RETURNS

%token ARROW
%token REMOP
%token EXPOP
%token OROP
%token NOTOP
%token CASE
%token ELSE
%token ENDCASE
%token ENDIF
%token IF
%token OTHERS
%token REAL
%token THEN
%token WHEN
%token BOOL_LITERAL
%token REAL_LITERAL


%%

function:	
	function_header variables body ;

	
function_header:	
	FUNCTION IDENTIFIER RETURNS type ';' ;

variables:
	variable variables |
	;

variable:
	IDENTIFIER ':' type IS statement_ ;

type:
	INTEGER |
	BOOLEAN |
	REAL;

body:
	BEGIN_ statement_ END ';' ;
    
statement_:
	statement ';' |
	error ';' ;
	
statement:
	expression |
	REDUCE operator reductions ENDREDUCE |
	if_statement |
	case_statement;

if_statement:
    IF expression THEN statement_ ELSE statement_ ENDIF ;

case_statement:
    CASE IDENTIFIER IS case_clauses ENDCASE;

case_clauses:
    when_clause case_clauses |
    others_clause |
    ;

when_clause:
    WHEN INT_LITERAL ARROW statement_;

others_clause:
    OTHERS ARROW statement_;

operator:
	ADDOP |
	MULOP ;

reductions:
	reductions statement_ |
	;
		    
expression:
	expression ANDOP relation |
	relation ;

relation:
	relation RELOP term |
	term;

term:
	term ADDOP factor |
	factor ;
      
factor:
	factor MULOP primary |
	primary ;

primary:
	'(' expression ')' |
	INT_LITERAL | 
	IDENTIFIER |
	REAL_LITERAL |
	BOOL_LITERAL;
    
%%

void yyerror(const char* message)
{
	appendError(SYNTAX, message);
}

int main(int argc, char *argv[])    
{
	firstLine();
	yyparse();
	lastLine();
	return 0;
} 
