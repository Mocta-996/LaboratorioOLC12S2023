import { AbstractSQLExpression } from "../../abstract/AbstractSQLExpression";
import { Context } from "../../abstract/Context";
import { FieldExpression } from "../../terminal/FieldExpression";
import { BlockStatementExpression } from "./BlockStatementExpression";

export class CallMethodExpression extends AbstractSQLExpression {
  constructor(
    line: number,
    column: number,
    private name: String,
    private args: AbstractSQLExpression[]
  ) {
    super(line, column);
  }

  public interpret(context: Context) {
    // ejecutar la funcion
    const method = context.getMethod(this.name);
    if (method != null) {
      // crear un nuevo entorno
      const ctxM = new Context(context.getGlobal());
      //  guardar los parametros
      // verificar la cantidad de parametros
      if (method.params.length == this.args.length) {
        // recorrer los parametros
        for (let i = 0; i < method.params.length; i++) {
          /* pasos:
                  1. obtener el nombre y el tipo del parametro
                  2. obtener el valor del argumento
                  3. guardar la variable en el entorno/contexto con su respectivo nombre, tipo y valor
                  */
          ctxM.saveV(id,valorl, tipo);
        }
        // ejecutar el cuerpo del metodo/funcion
        method.blockStatement.interpret(ctxM);
      } else {
        console.log(
          "Error, The method " +
            this.name +
            " could not be executed, line " +
            this.line +
            " and column " +
            this.column
        );
      }
    }
  }
}
