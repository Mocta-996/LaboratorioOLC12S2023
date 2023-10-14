
import { Context } from "./Context";
export abstract class AbstractSQLExpression {
  public line: number;
  public column: number;
  constructor(line: number, column: number) {
    this.line = line;
    this.column = column;
  }

  public abstract interpret(context: Context): any;
}
