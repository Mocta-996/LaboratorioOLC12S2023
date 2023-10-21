// importar librerias
import { Request, Response } from "express";
import { Context } from "./interpreterSQL/abstract/Context";
import { MethodExpression } from "./interpreterSQL/nonterminal/moreStatements/MethodExpression";

class InterpreteController {

  // metodo ping
  public pong(req: Request, res: Response) {
    res.send("Pong interpreter controller OLC1");
  }

  // metodo para interpretar el codigo fuente
  public interpretar(req: Request, res: Response) {
    // variable parser
    var parser = require("./interpreterSQL/grammar");

    // variable codigo fuente
    const text = req.body.code;
    console.log("Codigo de entrada:  " + text);

    try {
      // parsear el codigo fuente
      const ast = parser.parse(text); //ast es el arbol de sintaxis abstracta
      try {
        const globalContext = new Context(null);
        
        for (const inst of ast){
          if(inst instanceof MethodExpression){
            inst.interpret(globalContext);
          } 
        }

        for (const inst of ast){
          if(!(inst instanceof MethodExpression)){
            inst.interpret(globalContext);
          } 
        }
        
        const simbolos = globalContext.getSimbolos();
        res.json({ consola:"ejecutado correctamente", errores: "ninguno" , simbolos: simbolos});

      } catch (error) {
        console.log(error);
        res.json({
          consola: error,
          errores: error,
        });
      }
    } catch (err) {
      console.log(err);
      res.json({
        consola: err,
        errores: err,
      });
    }
  }
}

export const interpreteController = new InterpreteController();
