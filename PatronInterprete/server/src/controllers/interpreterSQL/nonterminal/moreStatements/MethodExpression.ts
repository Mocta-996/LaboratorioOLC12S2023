import { AbstractSQLExpression } from '../../abstract/AbstractSQLExpression';
import { Context } from '../../abstract/Context';
import { FieldExpression } from '../../terminal/FieldExpression';
import { BlockStatementExpression } from './BlockStatementExpression';

export class MethodExpression extends AbstractSQLExpression {


    constructor( line: number, column: number,private name: String,public params: FieldExpression[],public blockStatement:BlockStatementExpression ) {
      super(line, column);
    }

    public interpret(context : Context){
      // guardar el metodo/funcion
      context.saveMethod(this.name.toString(),this);
    }
}