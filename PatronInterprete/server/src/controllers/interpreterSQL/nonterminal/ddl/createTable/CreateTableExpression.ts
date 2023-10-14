import { AbstractSQLExpression } from '../../../abstract/AbstractSQLExpression';
import { FieldExpression } from '../../../terminal/FieldExpression';
import { Context } from '../../../abstract/Context';
import { Table } from '../../../bd/Table';

export class CreateTableExpression extends AbstractSQLExpression {


  constructor( line: number, column: number,private name: String,private fields: FieldExpression[]) {
    super(line, column);
  }

  public interpret(context: Context){  
    const fields = this.fields.map((item) => {
      const value = item.interpret(context);
      return value;
    });
    // se crea una tabla con el nombre:
    context.saveTable(this.name.toString(),new Table(this.name.toString(),fields));
  }


}
