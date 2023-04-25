// This file contains the bodies of the evaluation functions

#include <string>
#include <vector>
#include <cmath>

using namespace std;

#include "values.h"
#include "listing.h"

int evaluateReduction(Operators operator_, int head, int tail)
{
	if (operator_ == ADD)
		return head + tail;
	return head * tail;
}


int evaluateRelational(int left, Operators operator_, int right)
{
    int result;
    switch (operator_)
    {
        case LESS:
            result = left < right;
            break;
        case GREATER:
            result = left > right;
            break;
        case LESS_EQUAL:
            result = left <= right;
            break;
        case GREATER_EQUAL:
            result = left >= right;
            break;
        case EQUAL:
            result = left == right;
            break;
        case NOT_EQUAL:
            result = left != right;
            break;
    }
    return result;
}


int evaluateArithmetic(int left, Operators operator_, int right)
{
    double result;
    switch (operator_)
    {
        case ADD:
            result = left + right;
            break;
        case SUBTRACT:
            result = left - right;
            break;
        case MULTIPLY:
            result = left * right;
            break;
        case DIVIDE:
            result = left / right;
            break;
        case MODULUS:
            result = fmod(left, right);
            break;
    }
    return static_cast<int>(round(result));
}


int evaluateComparison(int left, Operators oper, int right) {
    switch (oper) {
        case 1: // LT
            return left < right;
        case 2: // LTE
            return left <= right;
        case 3: // GT
            return left > right;
        case 4: // GTE
            return left >= right;
        case 5: // EQ
            return left == right;
        case 6: // NEQ
            return left != right;
        default:
            return 0;
    }
}

