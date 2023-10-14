
import { Table } from "../bd/Table";
import { Literal } from "./Return";

export class Context {
    private tables = new Map<string,Table>();   //  mapa de tablas

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
      this.getTables();

    } else {
      console.log("Error: la tabla no existe");
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


}