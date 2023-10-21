
import { Table } from "../bd/Table";
import { Literal } from "./Return";
import { MethodExpression } from "../nonterminal/moreStatements/MethodExpression";

export class Context {
    private tables = new Map<string,Table>();   //  mapa de tablas
    private methods = new Map<string,MethodExpression>();   //  mapa de metodos/funciones
    private tablaSimbolos = Array<tablaSimbolos>();   //  mapa de metodos/funciones

    // constructor
    constructor(private anterior: Context | null) {
        this.tables= new Map<string,Table>();
    }

    // agregar una tabla
    public saveTable(id: string, table: Table) {
        // verificar el ambito
        let env: Context | null = this;
        // verificar si la tabla ya existe
        if (!env.tables.has(id.toLowerCase())) {
          // guardar la tabla en una tabla de simbolos
          env.tables.set(id.toLowerCase(),table);
          this.tablaSimbolos.push(new tablaSimbolos(id,table));
        }else {
          console.log("Error, La tabla "+id+" ya existe en el entorno");
          //printlist.push("Error, La tabla "+id+" ya existe en el entorno");
        }
      }
    
  // INSERTAR UNA TUPLA
  public Insert(id: string, fields: [], values: Literal[]) {
    // obtener ambito global
    const contextGlobal = this.getGlobal();
    // verificar si la tabla existe
    if (contextGlobal.tables.has(id.toLowerCase())) {
      // obtener la tabla
      const table = contextGlobal.tables.get(id.toLowerCase())!;
      const fields_ = table.fields;

      const newTuple: { [key: string]: any } = {};
    
      fields_.forEach((literal) => {
        newTuple[literal.value] = null;
      });

      fields.forEach((field, index) => {
        newTuple[field]= values[index];
      });

      // insertar la tupla en la tabla
      table.tuples.push(newTuple);
      //this.getTables();

    } else {
      console.log("Error: la tabla no existe");
    }

  }


  // GUARDAR UN METODO/ FUNCION
  public saveMethod(id: string,method: MethodExpression) {
    // verificar el ambito
    let ctx: Context | null = this;
    // verificar si la funcion/metodo ya existe
    if (!ctx.methods.has(id.toLowerCase())) {
      // guardar el metodo/funcion en una tabla de simbolos 
      ctx.methods.set(id.toLowerCase(), method);
    } else {
      console.log("Error, the method " + id + " already exists in the context.");
    }
  }

   // OBTENER UN METODO
   // acceder a un metodo
   public getMethod(id: String): MethodExpression | null {
    // verificar el ambito
    let ctx: Context | null = this;
    // buscar el metodo
    while (ctx != null) {
      // verificar si el metodo existe
      if (ctx.methods.has(id.toLowerCase())) {
        // retornar la variable
        return ctx.methods.get(id.toLowerCase())!;
      }
      // cambiar de ambito
      ctx = ctx.anterior;
    }
    // retornar null si no se encontro la variable
    return null;
  }







  // select de una tabla
  public SelectFrom(id: string): String {
    // obtener ambito global
    const contextGlobal = this.getGlobal();
    // verificar si la tabla existe
    if (contextGlobal.tables.has(id.toLowerCase())) {
      // obtener la tabla
      const table_ = contextGlobal.tables.get(id.toLowerCase())!;

      const columns:Array<string> = Object.keys(table_.tuples[0]);

      // Construye la tabla como un array de filas
      const table:Array<string[]>= [];

      // Agrega la primera fila como encabezado
      table.push(columns);

      // Agrega las filas de datos
      table_.tuples.forEach(obj => {
        const row = columns.map(column => obj[column].value);
        table.push(row);
      });

      // Convierte la tabla en un string
      const tableString = table.map(row => row.join('\t')).join('\n');

      // Muestra la tabla en la consola
      console.log(tableString);
      return tableString;
    } else {
      return "Error: la tabla no existe";
     
    }

  }

   // obtener el entorno global
   public getGlobal(): Context {
    // verificar el ambito
    let context: Context | null = this;

    // buscar la variable
    while (context.anterior != null) {
      // cambiar de ambito
      context = context.anterior;
    }

    // retornar el entorno global
    return context;
  }

    // obtener todas las tablas
    public getTables(){

      //tabla global
      const contextGlobal = this.getGlobal();
      // imprimir el nombre de todas las tablas
      console.log("Nombre de todas las tablas: ");
      for (const [key, value] of contextGlobal.tables) {
        console.log(key);
        // imprimir el nombre de todos los campos
        console.log("Nombre de todos los campos: ");
        value.tuples.forEach((field) => {
          console.log(field);
        });
      }
    }

    public getSimbolos(){
      console.log("retornar un arreglos con todos los simblos: ");
      
    }


}