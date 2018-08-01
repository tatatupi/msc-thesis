%{

#include "global.h"
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#include <ctype.h>

int yyerror(char*);

%}


%token   NUMBER
%token   VARIABLE
%token   PLUS MINUS MULTIPLY DIVIDE POWER SQRT
%token   SIN COS TAN
%token   LOG LN EXP
%token   EQUAL
%token   LEFT_PARENTHESIS RIGHT_PARENTHESIS
%token   NEW_LINE
%token   END

%left    EQUAL
%left    PLUS MINUS
%left    MULTIPLY DIVIDE
%left    SQRT
%left    SIN COS TAN
%left    LOG LN EXP
%left    NEG		

%right   POWER

%start   Input


%%


Input:
   /* Empty */		
   | Input Line
   ;

Line:
   NEW_LINE
   | Expression NEW_LINE {
         if (terminal) {
             printf("Resultado: %lf\n",$1);
         } else {
             out_parse = $1;
             return(0);
         }
	}
   | VARIABLE EQUAL Expression { int ind = $1; sym[ind] = $3; }
   | END { return(0); }
   ;

Expression:
   NUMBER     { $$ = $1; }
   | VARIABLE { int ind = $1; $$ = sym[ind]; }
   | Expression PLUS Expression     { $$ = $1 + $3;    }
   | Expression MINUS Expression    { $$ = $1 - $3;    }
   | Expression MULTIPLY Expression { $$ = $1 * $3;    }
   | Expression DIVIDE Expression   { $$ = $1 / $3;    }
   | MINUS Expression %prec NEG     { $$ = -$2;        }
   | Expression POWER Expression    { $$ = pow($1,$3); }
   | SQRT Expression    { $$ = sqrt($2);  } 
   | SIN Expression     { $$ = sin($2);   }
   | COS Expression     { $$ = cos($2);   }
   | TAN Expression     { $$ = tan($2);   }  
   | LOG Expression     { $$ = log10($2); }
   | LN  Expression     { $$ = log($2);   }
   | EXP Expression     { $$ = exp($2);   }
   | LEFT_PARENTHESIS Expression RIGHT_PARENTHESIS { $$ = $2; }
   ;


%%


int yyerror(char *s) {
	printf("%s\n",s);
}
