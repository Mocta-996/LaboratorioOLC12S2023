import { Literal } from "../abstract/Return";

export class Table {
    public name: string;
    public tuples: Array<Object> =[];
    public fields : Array<Literal> = [];

    constructor(name: string, tuples: any, fields: []) {
        this.name = name;
        this.tuples = tuples;
        this.fields = fields;
    }
}
