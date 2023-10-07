import { AbstractSQLExpression } from '../abstract/AbstractSQLExpression';
import { Type, Literal } from '../abstract/Return';

export class FieldExpression extends AbstractSQLExpression {


  constructor( line: number, column: number,
    private name: String,
    private type: Type
  ) {
    super(line, column);
  }

  public interpret(): Literal{
    // verificar el tipo de dato
    return {value: this.name, type: this.type};
  }


}
