/* Definición Léxica */
%lex

%options case-insensitive
%x string

%%

[ \r\t]+            {}                      // espacio en blanco
\n                  {}                      // salto de linea
(\/\/).*                             {}     // comentario linea
[/][*][^*]*[*]+([^/*][^*]*[*]+)*[/]  {}     // comentario multilinea


// simbolos reservados
";"                 return 'TK_PTCOMA';
"("                 return 'TK_PARIZQ';
")"                 return 'TK_PARDER';
"."                 return 'TK_PUNTO';
":"                 return 'TK_DOSPUNTOS';
","                 return 'TK_COMA';
"["                 return 'TK_CORIZR';
"]"                 return 'TK_CORDER';
"{"                 return 'TK_LLAVEIZQ';
"}"                 return "TK_LLAVEDER";
"*"                 return "TK_ASTERISCO";


"="                 return 'TK_IGUALACION';
"!="                return 'TK_DIFERENCIACION';
"<"                 return 'TK_MENORQUE';
"<="                return 'TK_MENORIGUAL';
">"                 return 'TK_MAYORQUE';
">="                return 'TK_MAYORIGUAL';
"@"                 return 'TK_ARROBA';

// tipos de variables
"int"               return 'TK_TENTERO';
"double"            return 'TK_TDOUBLE';
"date"              return 'TK_TDATE';
"varchar"           return 'TK_TVARCHAR';
"boolean"           return 'TK_TBOOLEAN';

"true"              return 'TK_TRUE';
"false"             return 'TK_FALSE';
"null"              return 'TK_NULL';

"create"          return 'TK_CREATE';
"table"           return 'TK_TABLE';
"insert"      return 'TK_INSERT';
"into"        return 'TK_INTO';
"values"      return 'TK_VALUES';
"select"      return 'TK_SELECT';
"from"        return 'TK_FROM';
"procedure"   return 'TK_PROCEDURE';
"as"          return 'TK_AS';
"begin"       return 'TK_BEGIN';
"end"         return 'TK_END';
"print"       return 'TK_PRINT';

[a-zA-Z][a-zA-Z0-9_]*   return 'TK_IDENTIFICADOR';
[0-9]+\b                return 'TK_ENTERO';
[0-9]+("."[0-9]+)\b     return 'TK_DOUBLE';
(\d{4})-(\d{1,2})-(\d{1,2}) return 'TK_DATE';
["]                             {cadena="";this.begin("string");}
<string>[^"\\]+                 {cadena+=yytext;}
<string>"\\\""                  {cadena+="\"";}
<string>"\\n"                   {cadena+="\n";}
<string>"\\t"                   {cadena+="\t";}
<string>"\\\\"                  {cadena+="\\";}
<string>"\\\'"                  {cadena+="\'";}
<string>["]                     {yytext=cadena; this.popState(); return 'TK_VARCHAR';}


<<EOF>>                 return 'EOF';

.                       { console.error('Este es un error léxico: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column);}
/lex

%{
  // importar tipos
	const {Type} = require('./abstract/Return');
	const {FieldExpression} = require('./terminal/FieldExpression');
	const {CreateTableExpression} = require('./nonterminal/ddl/createTable/CreateTableExpression');
	const {LiteralExpression} = require('./terminal/LiteralExpression');
  const {InsertExpression} = require('./nonterminal/dml/insert/InsertExpression');
  const {SelectExpression} = require('./nonterminal/dml/select/SelectExpression');
  const {MethodExpression} = require('./nonterminal/moreStatements/MethodExpression');
  const {BlockStatementExpression} = require('./nonterminal/moreStatements/BlockStatementExpression');
  const {PrintExpression} = require('./nonterminal/moreStatements/PrintExpression');
  const {CallMethodExpression} = require('./nonterminal/moreStatements/CallMethodExpression');
%}


%start ini
%% /* Definición de la gramática */
/* CREATE TABLE Clientes ( 
	ID_Cliente INT,
	Nombre VARCHAR,
	CorreoElectronico VARCHAR
);
*/
ini
	: instrucciones EOF {return $1;}

;

instrucciones
	: instrucciones instruccion 	{ $1.push($2); $$ = $1; }
	| instruccion					{ $$ = [$1]; }
;

instruccion
	: ddl   TK_PTCOMA       { $$ = $1; }
	| dml   TK_PTCOMA       { $$ = $1; }
  | guardarMetodo TK_PTCOMA { $$ = $1; }
  | print TK_PTCOMA         { $$ = $1; }
  | llamadaMetodo TK_PTCOMA { $$ = $1; }
	| error TK_PTCOMA
  	{   console.error('Este es un error sintáctico: ' + yytext + ', en la linea: ' + this._$.first_line + ', en la columna: ' + this._$.first_column);}
;

ddl
  :crearTabla { $$ = $1; }
;

crearTabla
  : TK_CREATE TK_TABLE TK_IDENTIFICADOR TK_PARIZQ listaAtributosTabla TK_PARDER 
  { $$ = new CreateTableExpression(@1.first_line, @1.first_column,$3, $5); }
;

listaAtributosTabla
	: listaAtributosTabla TK_COMA atributoTabla { $1.push($3); $$ = $1;  }
  	| atributoTabla { $$ = [$1]; }
;

atributoTabla
  : TK_IDENTIFICADOR tipos { $$ = new FieldExpression(@1.first_line, @1.first_column,$1, $2); }
;



// DML
dml
  : insertar { $$ = $1; }
  | select { $$ = $1; }
;

insertar
	: TK_INSERT TK_INTO TK_IDENTIFICADOR TK_PARIZQ listaIDS TK_PARDER TK_VALUES TK_PARIZQ listaValores TK_PARDER
  	{ $$ = new InsertExpression(@1.first_line, @1.first_column,$3, $5,$9); }
;

listaIDS
  : listaIDS TK_COMA TK_IDENTIFICADOR { $1.push($3); $$ = $1;  }
  | TK_IDENTIFICADOR { $$ = [$1]; }
;

listaValores
  : listaValores TK_COMA valor { $1.push($3); $$ = $1;  }
  | valor { $$ = [$1]; }
;

valor
  : TK_ENTERO { $$ = new LiteralExpression(@1.first_line, @1.first_column,$1, Type.INT); }
  | TK_DOUBLE { $$ = new LiteralExpression(@1.first_line, @1.first_column,$1, Type.DOUBLE); }
  | TK_DATE { $$ = new LiteralExpression(@1.first_line, @1.first_column,$1, Type.DATE); }
  | TK_VARCHAR { $$ = new LiteralExpression(@1.first_line, @1.first_column,$1, Type.VARCHAR); }
  | TK_TRUE { $$ = new LiteralExpression(@1.first_line, @1.first_column,$1, Type.BOOLEAN);}
  | TK_FALSE { $$ = new LiteralExpression(@1.first_line, @1.first_column,$1, Type.BOOLEAN); }
  | TK_NULL { $$ = new LiteralExpression(@1.first_line, @1.first_column,$1, Type.NULL); }
;


select 
  : TK_SELECT TK_ASTERISCO TK_FROM TK_IDENTIFICADOR { $$ = new SelectExpression(@1.first_line, @1.first_column, $4); }   
;


// GUARDAR METOODOS/FUNCIONES
guardarMetodo
  : TK_CREATE TK_PROCEDURE TK_IDENTIFICADOR listaParametros TK_AS sentencias
  { $$ = new MethodExpression(@1.first_line, @1.first_column,$3,$4,$6); }
;

listaParametros
  : listaParametros TK_COMA parametro { $1.push($3); $$ = $1;  }
  | parametro { $$ = [$1]; }
;

parametro
  : TK_ARROBA TK_IDENTIFICADOR tipos { $$ = new FieldExpression(@1.first_line, @1.first_column,$2, $3); }
;

sentencias
  : TK_BEGIN instrucciones TK_END
  { $$ = new BlockStatementExpression(@1.first_line, @1.first_column,$2); }
  | TK_BEGIN TK_END  { $$ = new BlockStatementExpression(@1.first_line, @1.first_column,[]); }
;

// print
print
  : TK_PRINT expression { $$ = new PrintExpression(@1.first_line, @1.first_column,$2); }
;

expression
  :valor { $$ = $1; }
;

// llamada metodo
llamadaMetodo
  : TK_IDENTIFICADOR TK_PARIZQ listaValores TK_PARDER
  { $$ = new CallMethodExpression(@1.first_line, @1.first_column,$1,$3); }
;

tipos
  : TK_TENTERO      { $$ = Type.INT; }
  | TK_TDOUBLE      { $$ = Type.DOUBLE; }
  | TK_TDATE        { $$ = Type.DATE; }
  | TK_TVARCHAR     { $$ = Type.VARCHAR; }
  | TK_TBOOLEAN     { $$ = Type.BOOLEAN; }
;