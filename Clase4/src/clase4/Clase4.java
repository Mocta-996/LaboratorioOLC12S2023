/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Main.java to edit this template
 */
package clase4;
// importar las clases del analizador
import Analizador.parser;
import Analizador.scanner;

/**
 *
 * @author Pilo Tuy
 */


public class Clase4 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        //System.out.println("hola compi1");
        String codigoFuente = "// esto es una prueba de un comentario de linea\n " +
        "/* esto es una prueba de un comentario de bloque \n Segunda linea */\n"+
        "void MAIN () { \n"+
        "   int a = 5; \n"+
        "}";
        Ejecutar(codigoFuente);
    }

    private static void Ejecutar (String codigoFuente) {
        try {
            // realizar el analisis lexico con el scanner
            scanner scan = new scanner(new java.io.StringReader(codigoFuente));
            //  sintactico con el parser
            parser parser = new parser(scan);
            parser.parse();
            System.out.println("Analisis realizado correctamente");
        } catch (Exception ex) {
            System.out.println("Error: " + ex.getMessage());
        }

    }
    
}
