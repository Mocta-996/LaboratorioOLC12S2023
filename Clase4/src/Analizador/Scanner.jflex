package Analizador;
import java_cup.runtime.Symbol;

%%

%{
    //Código de usuario
%}

%class scanner  // definir como trabajara el scanner 
%cup            // trabajar con cup 
%public         // tipo publico
%line           // conteo de lineas - linea por linea
%column         // contar columna por columna
%unicode        // tipo de codigicacion para que acepte la  ñ u otro caracter
%ignorecase     // case insensitive 


//expresiones
ENTERO  = [0-9]+   
DECIMAL = [0-9]+("."[  |0-9]+)?
LETRA   = [a-zA-ZÑñ]
ID      = {LETRA}({LETRA}|{ENTERO}|"_")*
CADENA  = [\"][^\"\n]+[\"]
SPACE   = [\ \r\t\f\t]
ENTER   = \r|\n|\r\n
CARACTER = [^\r\n]
COMENTARIOLINEA = "//" {CARACTER}* {ENTER}?
COMENTARIOMULTILINEA = "/*" [^/]~ "*/"

//simbolos
PAR_IZQ     = "("
PAR_DER     = ")"
LLAV_IZQ    = "{"
LLAV_DER    = "}" 
COR_IZQ     = "["
COR_DER     = "]"
IGUAL       = "-"
MAYOR_QUE   = ">"
PTCOMA      = ";"
COMA        = ","
DOSPUNTOS   = ":"
MAS = "+"
MENOS = "-"
POR = "*"
DIV = "/"
COMILLA_SIMPLE = \\'
COMILLA_DOBLE = \\\"


//palabras reservadas
RVOID = "void"
RMAIN = "main"
RINT = "int"
RDOUBLE = "double"
RCHAR = "char"
RBOOL = "bool"
RSTRING = "string"

%%

<YYINITIAL> {RVOID}  {   return new Symbol(sym.RVOID, yyline, yycolumn,yytext());  }
<YYINITIAL> {RMAIN}  {   return new Symbol(sym.RMAIN, yyline, yycolumn,yytext());  }
<YYINITIAL> {RINT}   {   return new Symbol(sym.RINT, yyline, yycolumn,yytext());   }
<YYINITIAL> {RDOUBLE}    {   return new Symbol(sym.RDOUBLE, yyline, yycolumn,yytext());    }
<YYINITIAL> {RCHAR}  {   return new Symbol(sym.RCHAR, yyline, yycolumn,yytext());  }
<YYINITIAL> {RBOOL}  {   return new Symbol(sym.RBOOL, yyline, yycolumn,yytext());  }
<YYINITIAL> {RSTRING}    {   return new Symbol(sym.RSTRING, yyline, yycolumn,yytext());    }

<YYINITIAL> {PAR_IZQ}   {   return new Symbol(sym.PAR_IZQ, yyline, yycolumn,yytext());  }
<YYINITIAL> {PAR_DER}   {   return new Symbol(sym.PAR_DER, yyline, yycolumn,yytext());  }
<YYINITIAL> {LLAV_IZQ}  {   return new Symbol(sym.LLAV_IZQ, yyline, yycolumn,yytext()); }
<YYINITIAL> {LLAV_DER}  {   return new Symbol(sym.LLAV_DER, yyline, yycolumn,yytext()); }
<YYINITIAL> {COR_IZQ}   {   return new Symbol(sym.COR_IZQ, yyline, yycolumn,yytext());  }
<YYINITIAL> {COR_DER}   {   return new Symbol(sym.COR_DER, yyline, yycolumn,yytext());  }
<YYINITIAL> {IGUAL}     {   return new Symbol(sym.IGUAL, yyline, yycolumn,yytext());    }
<YYINITIAL> {PTCOMA}    {   return new Symbol(sym.PTCOMA, yyline, yycolumn,yytext());   }

<YYINITIAL> {MAS}       {   return new Symbol(sym.MAS, yyline, yycolumn,yytext());  }

<YYINITIAL> {MENOS}     {   return new Symbol(sym.MENOS, yyline, yycolumn,yytext());    }

<YYINITIAL> {POR}       {   return new Symbol(sym.POR, yyline, yycolumn,yytext());   }

<YYINITIAL> {DIV}       {   return new Symbol(sym.DIV, yyline, yycolumn,yytext());   }

<YYINITIAL> {ENTERO}    {   return new Symbol(sym.ENTERO, yyline, yycolumn,yytext());   }

<YYINITIAL> {DECIMAL}   {   return new Symbol(sym.DECIMAL, yyline, yycolumn,yytext());  }

<YYINITIAL> {SPACE}     { /*Espacios en blanco, ignorados*/ }
<YYINITIAL> {ENTER}     { /*Saltos de linea, ignorados*/}

<YYINITIAL> {COMENTARIOLINEA} { /*Comentarios de una linea, ignorados*/ System.out.println("Comentario de una linea: "+yytext() ); }
<YYINITIAL> {COMENTARIOMULTILINEA} { /*Comentarios multilinea, ignorados*/ System.out.println("Comentario multilinea: "+yytext() ); }
<YYINITIAL> . {
        String errLex = "Error léxico : '"+yytext()+"' en la línea: "+(yyline+1)+" y columna: "+(yycolumn+1);
        System.out.println(errLex);
}

