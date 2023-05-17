%{
#include <stdio.h>
#include <stdlib.h>
int yylex();
void yyerror(const char* s);
int evaluateLogicalOrExpression(int var1, int var2);
int evaluateLogicalAndExpression(int var1, int var2);
int evaluateLogicalNotExpression(int var1);
int count = 0;
%}

%union {
    int ival;
}

%token <ival> NUMBER
%type <ival> expression
%token OR_OP NOT_OP AND_OP COLON SEMICOLON


%%

program: expression { printf("OUTPUT: %d\n",$1); }

expression:
NUMBER AND_OP NUMBER SEMICOLON { generateIntermediateCodeAnd($1, $3);  $$ = evaluateLogicalAndExpression($1, $3);}
| NUMBER OR_OP NUMBER SEMICOLON { generateIntermediateCodeOr($1, $3);  $$ = evaluateLogicalOrExpression($1, $3);}
| NOT_OP NUMBER SEMICOLON { generateIntermediateCodeNot($2);  $$ = evaluateLogicalNotExpression($2);}
| NUMBER { $$ = $1; }

%%

int evaluateLogicalOrExpression(int var1, int var2){
  return var1||var2;
}

int evaluateLogicalNotExpression(int var1){
  return !var1;
}

int evaluateLogicalAndExpression(int var1, int var2){
  return var1&&var2;
}

void generateIntermediateCodeAnd(int var1, int var2){
  count = 0;
  printf("\nIntermediate Code:\n");
  printf("%d. T1 = %d\n", ++count,var1);
  printf("%d. T2 = %d\n", ++count, var2);
  printf("%d. T3 = T1 && T2\n",++count);
  printf("\n");
}
void generateIntermediateCodeOr(int var1, int var2){
  count = 0;
  printf("\nIntermediate Code:\n");
  printf("%d. T1 = %d\n", ++count, var1);
  printf("%d. T2 = %d\n", ++count, var2);
  printf("%d. T3 = T1 || T2\n", ++count);
  printf("\n");
}
void generateIntermediateCodeNot(int var1){
  count = 0;
  printf("\nIntermediate Code:\n");
  printf("%d. T1 = %d\n", ++count, var1);
  printf("%d. T1 = !T1\n", ++count);
  printf("\n");
}


int main()
{
  yyparse();
  return 0;
}

void yyerror(const char* s)
{
  printf("%s\n", s);
}
