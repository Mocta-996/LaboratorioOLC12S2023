import { AbstractSQLExpression } from '../../abstract/AbstractSQLExpression';
import { Context } from '../../abstract/Context';
import { FieldExpression } from '../../terminal/FieldExpression';
import { BlockStatementExpression } from './BlockStatementExpression';

export class PrintExpression extends AbstractSQLExpression {
  constructor(
    line: number,
    column: number,
    private expression: AbstractSQLExpression
  ) {
    super(line, column);
  }

  public interpret(context:Context){
    const value = this.expression.interpret(context); // value and type
    console.log("Esto deberia de mostrarse en consola: " ,value.value);
  }

}

