
import { AbstractSQLExpression } from '../../../abstract/AbstractSQLExpression';
import { Context } from '../../../abstract/Context';
import { LiteralExpression } from '../../../terminal/LiteralExpression';

export class SelectExpression extends AbstractSQLExpression {


    constructor( line: number, column: number,private name: String) {
      super(line, column);
  
    }
  
    public interpret(context : Context){
        
       const valor =  context.SelectFrom(this.name.toString().toLocaleLowerCase());
        console.log(valor);
        
    }
}