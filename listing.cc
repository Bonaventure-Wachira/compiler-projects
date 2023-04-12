#include <cstdio>
#include <string>
#include <queue>

using namespace std;

#include "listing.h"

static int lineNumber;
static string error = "";
static int totalErrors = 0;
static int lexicalErrors = 0;
static int syntaxErrors = 0;
static int semanticErrors = 0;
static queue<string> errorQueue;

static void displayErrors();

void firstLine()
{
    lineNumber = 1;
    printf("\n%4d  ",lineNumber);
}

void nextLine()
{
    lineNumber++;
    printf("%4d  ",lineNumber);
}

int lastLine()
{
    printf("\r");
    displayErrors();
    if (totalErrors == 0) {
        printf("Compiled Successfully\n");
    }
    return totalErrors;
}

void appendError(ErrorCategories errorCategory, string message)
{
    string messages[] = { "Lexical Error, Invalid Character ", "",
        "Semantic Error, ", "Semantic Error, Duplicate Identifier: ",
        "Semantic Error, Undeclared " };
    totalErrors++;

    if (errorCategory == LEXICAL) {
        lexicalErrors++;
    }
    else if (errorCategory == SYNTAX) {
        syntaxErrors++;
    }
    else {
        semanticErrors++;
    }

    errorQueue.push(messages[errorCategory] + message);
}

void displayErrors()
{
    while (!errorQueue.empty()) {
        printf("%s\n", errorQueue.front().c_str());
        errorQueue.pop();
    }

    if (totalErrors > 0) {
        printf("\nLexical Errors %d\nSyntax Errors %d\nSemantic Errors %d \n\n", lexicalErrors, syntaxErrors, semanticErrors);
        lexicalErrors = 0;
        syntaxErrors = 0;
        semanticErrors = 0;
    }
}
