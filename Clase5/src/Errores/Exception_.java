package Errores;
// objeto de tipo Exception_

public class Exception_  {
   // atributos
    private String tipo;
    private String descripcion;
    private String linea;
    private String columna;

    // constructor

    public Exception_(String tipo, String descripcion, String linea, String columna) {
        this.tipo = tipo;
        this.descripcion = descripcion;
        this.linea = linea;
        this.columna = columna;
    }

    // getters 

    public String getTipo() {
        return tipo;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public String getLinea() {
        return linea;
    }

    public String getColumna() {
        return columna;
    }
}