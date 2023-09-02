/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Main.java to edit this template
 */
package clase5;
// importar las clases del analizador
import Analizador.parser;
import Analizador.scanner;

/**
 *
 * @author Pilo Tuy
 */


public class Clase5 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        //System.out.println("hola compi1");
        String codigoFuente = "// esto es una prueba de un comentario de linea\n " +
        "/* esto es una prueba de un comentario de bloque \n Segunda linea */\n"+
        "void main () { \n"+
        "   Int var1 = 5; \n"+
        "   Int var2 = $; \n"+
        "   Int var3 = 5; \n"+
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

             // generar reporte de errores lexicos
            if (scanner.erroresLexicos.isEmpty()) {
                System.out.println("No se encontraron errores lexicos");
            } else {
                scanner.erroresLexicos.forEach((error) -> {
                    System.out.println(error.getTipo() + "| " + error.getDescripcion() + "| " + error.getLinea() + "| " + error.getColumna());
                });
            }
            
            // generar reporte de errores sintacticos
            if (parser.erroresSintacticos.isEmpty()) {
                System.out.println("No se encontraron errores sintacticos");
            } else {
                parser.erroresSintacticos.forEach((error) -> {
                    System.out.println(error.getTipo() + "| " + error.getDescripcion() + "| " + error.getLinea() + "| " + error.getColumna());
                });
            }
        } catch (Exception ex) {
            System.out.println("Error: " + ex.getMessage());
        }

    }
    
}
