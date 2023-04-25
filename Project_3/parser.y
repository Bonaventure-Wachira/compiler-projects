%{

#include <iostream>
#include <string>
#include <vector>
#include <map>

using namespace std;

#include "values.h"
#include "listing.h"
#include "symbols.h"

int yylex();
void yyerror(const char* message);

Symbols<int> symbols;

int result;


%}

%define parse.error verbose

%union
{
	CharPtr iden;
	Operators oper;
	int value;
}

%token <iden> IDENTIFIER
%token <value> INT_LITERAL REAL_LITERAL
%token <value> BOOLEAN_LITERAL
%token REAL

%token <oper> ADDOP MULOP RELOP
%token ANDOP OROP
%token NOTOP

%token BEGIN_ BOOLEAN END ENDREDUCE FUNCTION INTEGER IS REDUCE RETURNS
%token IF THEN ELSE ENDIF


%type <value> body statement_ statement reductions expression relation not_expression comparison arithmetic_expression factor primary logical_expression if_statement
%type <oper> operator

%%

function:    
    function_header optional_variables body {result = $3;} ;
	
function_header:	
	FUNCTION IDENTIFIER RETURNS type ';' ;

optional_variables:
    variables |
    ;

variables:
    variable variables |
    variable;


variable:	
	IDENTIFIER ':' type IS statement_ {symbols.insert($1, $5);} ;

type:
	INTEGER |
	BOOLEAN |
	REAL;

body:
	BEGIN_ statement_ END ';' {$$ = $2;} ;
    
statement_:
    statement ';' {$$ = $1;} |
    if_statement |
    error ';' {$$ = 0;} ;


statement:
    expression |
    REDUCE operator reductions ENDREDUCE {$$ = $3;} |
    if_statement ;

if_statement:
    IF expression THEN statement_ ELSE statement_ ENDIF
    {
        if ($2) { $$ = $4; }
        else { $$ = $6; }
    } ;





operator:
	ADDOP |
	MULOP ;

reductions:
	reductions statement_ {$$ = evaluateReduction($<oper>0, $1, $2);} |
	{$$ = $<oper>0 == ADD ? 0 : 1;} ;

expression:
    logical_expression;

logical_expression:
    logical_expression OROP relation {$$ = $1 || $3;} |
    relation;

relation:
    relation ANDOP not_expression {$$ = $1 && $3;} |
    not_expression;

not_expression:
    NOTOP comparison {$$ = !$2;} |
    comparison;


comparison:
    arithmetic_expression RELOP arithmetic_expression {$$ = evaluateComparison($1, $2, $3);} |
    arithmetic_expression;

arithmetic_expression:
    arithmetic_expression ADDOP factor {$$ = evaluateArithmetic($1, $2, $3);} |
    factor;

factor:
    factor MULOP primary {$$ = evaluateArithmetic($1, $2, $3);} |
    primary;

primary:
    '(' expression ')' {$$ = $2;} |
    REAL_LITERAL |
    BOOLEAN_LITERAL |
    INT_LITERAL |
    IDENTIFIER {if (!symbols.find($1, $$)) appendError(UNDECLARED, $1);} |
    '(' if_statement ')' {$$ = $2;} ;

%%

void yyerror(const char* message)
{
	appendError(SYNTAX, message);
}

int main(int argc, char *argv[])    
{
	firstLine();
	yyparse();
	if (lastLine() == 0)
		cout << "Result = " << result << endl;
	return 0;
}
