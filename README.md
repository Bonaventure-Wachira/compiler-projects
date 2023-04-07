# Project 2


The second project involves modifying the syntactic analyzer for the attached compiler by 
adding to the existing grammar. The full grammar of the language is shown below. The 
highlighted portions of the grammar show what you must either modify or add to the existing 
grammar. 
 function: 
 function_header {variable} body 
 
function_header: 
 FUNCTION IDENTIFIER [parameters] RETURNS type ; 
 
variable: 
 IDENTIFIER : type IS statement
 
parameters: 
 parameter {, parameter} 
 parameter: 
IDENTIFIER : type
 
type: 
 INTEGER | REAL | BOOLEAN
 
body: 
 BEGIN statement END ;
 
statement: 
 expression ; | 
 REDUCE operator {statement} ENDREDUCE ; | 
IF expression THEN statement ELSE statement ENDIF ; |
CASE expression IS {case} OTHERS ARROW statement ENDCASE ;
 operator: 
ADDOP | MULOP
 
case: 
 WHEN INT_LITERAL ARROW statement
 expression: 
( expression ) | 
 expression binary_operator expression | 
 NOTOP expression | 
 INT_LITERAL | REAL_LITERAL | BOOL_LITERAL | 
 IDENTIFIER binary_operator: ADDOP | MULOP | REMOP | 
EXPOP | RELOP | ANDOP | OROP
In the above grammar, the red symbols are nonterminals, the blue symbols are terminals and the 
black punctuation are EBNF metasymbols. The braces denote repetition 0 or more times and the 
brackets denote optional. 





You must rewrite the grammar to eliminate the EBNF brace and bracket metasymbols and to 
incorporate the significance of parentheses, operator precedence and associativity for all 
operators. Among arithmetic operators the exponentiation operator has highest precedence 
following by the multiplying operators and then the adding operators. All relational operators 
have the same precedence. Among the binary logical operators, and has higher precedence than 
or. Of the categories of operators, the unary logical operator has highest precedence, the 
arithmetic operators have next highest precedence, followed by the relational operators and 
finally the binary logical operators. All operators except the exponentiation operator are left 
associative. The directives to specify precedence and associativity, such as %prec and %left, 
may not be used 
Your parser should be able to correctly parse any syntactically correct program without any 
problem. 
You must modify the syntactic analyzer to detect and recover from additional syntax errors using 
the semicolon as the synchronization token. To accomplish detecting additional errors an error 
production must be added to the function header, another to the variable declaration and a final 
one to the when clause of the case statement. 
Your bison input file should not produce any shift/reduce or reduce/reduce errors. Eliminating 
them can be difficult so the best strategy is not introduce any. That is best achieved by making 
small incremental additions to the grammar and ensuring that no addition introduces any such 
errors. 
An example of compilation listing output containing syntax errors is shown below: 
 1 -- Multiple errors 
 2 
3 function main a integer returns real; 
Syntax Error, Unexpected INTEGER, expecting ':' 
4 b: integer is * 2; 
Syntax Error, Unexpected MULOP 
5 c: real is 6.0; 
6 begin 
7 if a > c then 
8 b 3.0; 
Syntax Error, Unexpected REAL_LITERAL, expecting ';' 
9 else 
10 b = 4.; 
11 endif; 
12 ; 
Syntax Error, Unexpected ';', expecting END 
Lexical Errors 0 
Syntax Errors 4 
Semantic Errors 0 




You are to submit two files. 
• The first is a .zip file that contains all the source code for the project. The .zip file 
should contain the flex input file, which should be a .l file, the bison file, which should 
be a .y file, all .cc and .h files and a makefile that builds the project. 
• The second is a Word document (PDF or RTF is also acceptable) that contains the 
documentation for the project, which should include the following: 
a. A discussion of how you approached the project 
b. A test plan that includes test cases that you have created indicating what aspects 
of the program each one is testing and a screen shot of your compiler run on that 
test case 
c. A discussion of lessons learned from the project and any improvements that could 
be made 
