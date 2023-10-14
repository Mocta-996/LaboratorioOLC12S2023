
import { AbstractSQLExpression } from '../../../abstract/AbstractSQLExpression';
import { Context } from '../../../abstract/Context';
import { LiteralExpression } from '../../../terminal/LiteralExpression';

export class InsertExpression extends AbstractSQLExpression {


    constructor( line: number, column: number,private name: String,
      private fields: [],private values: LiteralExpression[]) {
      super(line, column);
  
    }
  
    public interpret(context : Context){
        if (this.fields.length == this.values.length) {
            // insertar la tupla en la tabla
            // obtener los valores en un arreglo
            const values = this.values.map((item) => {
              const value = item.interpret(context);
              return value;
            });
            context.Insert(this.name.toString().toLocaleLowerCase(),this.fields,values);
          } else {
            console.log("Error: la cantidad de campos no coincide con la cantidad de valores");
          }
        
    }
}