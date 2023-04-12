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
%token REAL_LITERAL
%token BOOL_LITERAL
%token REAL

%token ADDOP
%token MULOP
%token REMOP
%token EXPOP

%token RELOP
%token ANDOP
%token OROP
%token NOTOP

%token BEGIN_
%token BOOLEAN
%token END
%token ENDREDUCE
%token FUNCTION
%token INTEGER
%token IS
%token REDUCE
%token RETURNS
%token ASSIGN

%token SEMICOLON
%token IF
%token THEN
%token ELSE
%token ENDIF
%token CASE
%token WHEN
%token OTHERS
%token ARROW
%token ENDCASE

%%

/* The grammar goes here */

program:
    function_declaration
    | statement
    ;



statements: // Added statements rule
    statement
    | statement statements
    ;

function_declaration:
    FUNCTION IDENTIFIER '(' optional_parameters ')' RETURNS type body SEMICOLON
    | error SEMICOLON
    ;

optional_parameters:
    /* empty */
    | parameter_list
    ;


parameters_opt:
    parameters
    | %empty
    ;


parameters:
    '(' parameter_list ')'
    | error SEMICOLON
    ;

parameter_list:
    parameter
    | parameter ',' parameter_list
    | error SEMICOLON
    ;

parameter:
    IDENTIFIER ':' type
    | error SEMICOLON
    ;

type:
    INTEGER
    | REAL
    | BOOLEAN
    ;

body:
    BEGIN_ variable_declaration statement_list END SEMICOLON
    ;

statement:
    IDENTIFIER ASSIGN expression SEMICOLON
    | reduce_statement
    | if_statement
    | case_statement
    ;

variable_declaration:
    /* empty */
    | IDENTIFIER ':' type IS expression SEMICOLON variable_declaration
    ;

reduce_statement:
    REDUCE operator statement_list ENDREDUCE
    ;

if_statement:
    IF expression THEN statement else_part ENDIF
    ;

else_part:
    /* empty */
    | ELSE statement
    ;

case_statement:
    CASE expression IS case_list OTHERS ARROW statement ENDCASE
    ;

case_list:
    case
    | case_list case
    ;

case:
    WHEN INT_LITERAL ARROW statement
    | WHEN error SEMICOLON
    ;

statement_list:
    statement
    | statement statement_list
    ;

expression:
    simple_expression
    | expression binary_logical_operator simple_expression
    ;

simple_expression:
    term
    | simple_expression adding_operator term
    ;

term:
    factor
    | term multiplying_operator factor
    ;

factor:
    primary
    | unary_arithmetic_operator factor
    ;

primary:
    IDENTIFIER
    | INT_LITERAL
    | REAL_LITERAL
    | BOOL_LITERAL
    | '(' expression ')'
    ;

adding_operator:
    ADDOP
    | NOTOP
    ;

multiplying_operator:
    MULOP
    | REMOP
    ;

binary_logical_operator:
    ANDOP
    | OROP
    ;

unary_arithmetic_operator:
    ADDOP
    | NOTOP
    ;

operator:
    ADDOP
    | MULOP
    | REMOP
    | EXPOP
    ;

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
