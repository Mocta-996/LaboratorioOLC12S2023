# Tener instalado:
- nodejs
- jison

## Linux
- ### NodeJS
Instalar NodeJS
```sh
sudo apt install nodejs
```
Verificar la versión instalada de nodejs
```sh
node -v
```

Instalar el  sistema de gestión de paquetes por defecto para Node.js

```sh
sudo apt install npm
```
Verificar la versión instalada de npm

```sh
npm --version
```
- ### Jison
Instalar Jison

```sh
npm install jison -g
```

## Iniciar Proyecto
Iniciar el proyecto con npm.
La bandera -y sirve para seleccionar valores por defecto en los parámetros de inicialización.
```sh
npm init -y
```

Procedemos a crear un nuevo archivo llamado gramatica.jison

### Compilar gramática
```sh
jison gramatica.jison
```

### Ejecutar el script 
```sh
node parser
```
## Documentación oficial
- [Jison](https://gerhobbelt.github.io/jison/docs/)

- [NodeJS](https://nodejs.org/es)