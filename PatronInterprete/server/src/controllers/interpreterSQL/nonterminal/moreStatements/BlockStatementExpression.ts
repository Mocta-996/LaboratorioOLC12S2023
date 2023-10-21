import { AbstractSQLExpression } from '../../abstract/AbstractSQLExpression';
import { Context } from '../../abstract/Context';

export class BlockStatementExpression extends AbstractSQLExpression {

    constructor( line: number, column: number,private block:Array<AbstractSQLExpression>) {
        super(line, column);
  
    }

  public interpret(context : Context){
    // ejecutar las instrucciones 
    const newCtx = new Context(context);
    // recorre cada instruccion
    for(const statement of this.block){
        try{
            const ret = statement.interpret(newCtx);
            // si la instruccion es un return, retornar el valor
            if (ret != null && ret != undefined) {
                return ret;
            }
        }catch(e){
            console.log("Errro al ejecutar instrucciones")
        }
    }
  }
}