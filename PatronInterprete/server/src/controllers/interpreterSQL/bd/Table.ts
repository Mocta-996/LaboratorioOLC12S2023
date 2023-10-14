import { Literal } from "../abstract/Return";

export class Table {
    public name: string;
    public tuples: { [key: string]: any }[];
    public fields : Literal[];

    constructor(name: string, fields: Literal[]) {
        this.name = name;
        this.fields = fields;
        this.tuples = [];
    }
}
