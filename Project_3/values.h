// This file contains function definitions for the evaluation functions

typedef char* CharPtr;
enum Operators {LESS, GREATER, LESS_EQUAL, GREATER_EQUAL, EQUAL, NOT_EQUAL, ADD, SUBTRACT, MULTIPLY, DIVIDE, MODULUS, AND, OR, NOT};




int evaluateComparison(int left, Operators oper, int right);

int evaluateReduction(Operators operator_, int head, int tail);
int evaluateRelational(int left, Operators operator_, int right);
int evaluateArithmetic(int left, Operators operator_, int right);