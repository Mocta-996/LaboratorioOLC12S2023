/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Analizador;

/**
 *
 * @author Pilo Tuy
 */
public class Generador {
    public static void main(String[] args) {
        compilar();
    }

    private static void compilar(){
        
        try {
            
            String ruta = "src/Analizador/";    
            //ruta donde tenemos los archivos con extension .jflex y .cup
            String opcFlex[] = { ruta + "Scanner.jflex", "-d", ruta };
            jflex.Main.generate(opcFlex);
            String opcCUP[] = { "-destdir", ruta, "-parser", "parser", ruta + "Parser.cup" };
            java_cup.Main.main(opcCUP);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
}
