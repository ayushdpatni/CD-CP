%{
#include "logical.tab.h"
int tokenCount=0;
%}

%%

\/\/.*                    ;
\/\*([^*]|\*+[^\/])*\*+\/ ;
[ \t\n]          ;
-?[0-9]+        { yylval.ival = atoi(yytext); printf("%d\t:\t%s\tCONSTANT\n",++tokenCount,yytext); return NUMBER; }
"||"            { printf("%d\t:\t%s\tOR OPERATOR\n",++tokenCount,yytext); return OR_OP; }
"&&"            { printf("%d\t:\t%s\tAND OPERATOR\n", ++tokenCount, yytext); return AND_OP; }
[\!]            { printf("%d\t:\t%s\tNOT OPERATOR\n", ++tokenCount, yytext); return NOT_OP; }
[:]             {printf("%d\t:\t%s\tCOLON\n",++tokenCount,yytext); return COLON; }
[;]             {printf("%d\t:\t%s\tSEMI COLON\n",++tokenCount,yytext); return SEMICOLON; }
.               {printf("%d\t:\t%s\tUNKNOWN TOKEN\n",++tokenCount,yytext); return yytext[0]; }

%%

int yywrap() {
    return 1;
}
