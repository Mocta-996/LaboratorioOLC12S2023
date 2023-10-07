import { AbstractSQLExpression } from '../../../abstract/AbstractSQLExpression';
import { FieldExpression } from '../../../terminal/FieldExpression';

export class CreateTableExpression extends AbstractSQLExpression {


  constructor( line: number, column: number,private name: String,private fields: FieldExpression[]) {
    super(line, column);
  }

  public interpret(){
    // se crea una tabla con el nombre:
    console.log("Se crea una tabla con el nombre: "+this.name);
    // se crean los campos:
    console.log("Se crean los campos: ");
    for(let field of this.fields){
      console.log(field.interpret());
    }
  }


}
