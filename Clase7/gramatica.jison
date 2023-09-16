

/*
- Indicamos que queremos iniciar con la definición léxica, agregando las opciones deseadas
- Nuestro analizador no distinguirá diferencias entre mayúsculas y minúsculas.
*/

// Parte Léxica
/* Definición Léxica */
%lex

%options case-insensitive
/*
- Escribimos los patrones para los tokens que deseamos reconocer. 
- Para cada uno de ellos debemos retornar el nombre asociado al token.
*/

%%

"Evaluar"           return 'REVALUAR';
";"                 return 'PTCOMA';
"("                 return 'PARIZQ';
")"                 return 'PARDER';
"["                 return 'CORIZQ';
"]"                 return 'CORDER';

"+"                 return 'MAS';
"-"                 return 'MENOS';
"*"                 return 'POR';
"/"                 return 'DIVIDIDO';

/*expresiones regulares */
/* Espacios en blanco */
[ \r\t]+            {}
\n                  {}

[0-9]+("."[0-9]+)?\b    return 'DECIMAL';
[0-9]+\b                return 'ENTERO';

/* Las últimas dos expresiones son para reconocer el fin de la entrada y caracteres no válidos.*/
<<EOF>>                 return 'EOF';

.                       { console.error('Este es un error léxico: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); }
/lex


// Parte sintactica
/* Asociación de operadores y precedencia  ya que la gramática escrita es ambigua*/
// precedencia mas baja a la mas alta

%left 'MAS' 'MENOS'
%left 'POR' 'DIVIDIDO'
%left UMENOS

//símbolo Inicial.
%start ini

%% 
/* Definición de la gramática */
/*
- escribimos nuestras producciones
- cada No Terminal no debe definirse previamente
*/

ini
	: instrucciones EOF
;

instrucciones
	: instruccion instrucciones
	| instruccion
	| error { console.error('Este es un error sintáctico: ' + yytext + ', en la linea: ' + this._$.first_line + ', en la columna: ' + this._$.first_column); }
;

instruccion
	: REVALUAR CORIZQ expresion CORDER PTCOMA {
		console.log('El valor de la expresión es: ' + $3);
	}
;

expresion
	: MENOS expresion %prec UMENOS  { $$ = $2 *-1; }
	| expresion MAS expresion       { $$ = $1 + $3; }
	| expresion MENOS expresion     { $$ = $1 - $3; }
	| expresion POR expresion       { $$ = $1 * $3; }
	| expresion DIVIDIDO expresion  { $$ = $1 / $3; }
	| ENTERO                        { $$ = Number($1); }
	| DECIMAL                       { $$ = Number($1); }
	| PARIZQ expresion PARDER       { $$ = $2; }
;