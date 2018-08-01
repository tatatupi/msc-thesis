#include "SymbolicParse.h"
#include "lex.yy.c"
#include "y.tab.c"


void StrToLowerCase(char* str) {
    unsigned long i;
    unsigned long size = strlen(str);

    for (i = 0; i < size; ++i) {
        str[i] = tolower(str[i]);
    }
}


int _parse_by_terminal() {
    char *geptr = global_expr;
    char buf[100]; /* The maximum value of a expression or function */
    char *res;

    terminal = 1;
    while ((res=fgets(buf,100,stdin))!=NULL) {
        strcpy(geptr,buf);
        geptr += strlen(buf);
    }
    yyparse();
}


int _parse_eval(char* var, char* exp, double* out) {
    terminal = 0;

    /*	Converts the expression and variables to lower case. */
    StrToLowerCase(var);
    StrToLowerCase(exp);

    /* Falta incluir verificação de comprimento máximo de var+exp */
    sprintf(global_expr,"%s\n%s\n", var, exp);
    yyparse();

    *out = out_parse;
}
