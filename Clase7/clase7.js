var fs = require('fs'); 
var parser = require('./gramatica');


fs.readFile('./Entrada.txt', (err, data) => {
    if (err) throw err;
    parser.parse(data.toString());
});

/*
librería fs de Nodejs para leer archivos y también de nuestro parser
*/