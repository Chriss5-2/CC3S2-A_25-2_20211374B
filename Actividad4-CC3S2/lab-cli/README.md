# Actividad4
## Navegación básica
Se ejecutarán pruebas básicas de acuerdo al tipo de comando descrito
### pwd
Muestra el directorio actual en el que nos ubicamos
```bash
#pwd
/workspaces/CC3S2-A_25-2_20211374B/Actividad4-CC3S2/lab-cli
```
### ls
Enlista todos los archivos y directorios que existen
```bash
#ls
README.md
evidencias
```
#### Variaciones ls
**ls -l**: Enlista en formato largo mostrando los permisos que posee cada archivo
```bash
# ls -l
total 8
-rw-rw-rw-  1 codespace codespace  434 Sep 22 22:53 README.md
drwxrwxrwx+ 2 codespace codespace 4096 Sep 22 22:44 evidencias
```
**ls -a**: Enlista todos los archivos incluyendo los archivos ocultos
```bash
# ls -a
.
..
README.md
evidencias
```
### cd
Ayuda a cambiar de directorio del actual ubicado
- **cd /**: Va al directorio raíz
- **cd ~**: Nos ubica en el directorio root del usuario
- **cd ..**: Ayuda a retroceder de directorio o mejor dicho subir de nivel
- **cd /tmp**: Nos ayuda a dirigirnos a un directorio temporal sobre lo cual es muy usado cuando se trata de leer archivos no accesibles

## Globbing
- *: Se usa para seleccionar a cualquier cadena
- **?**: Nos indica que habrá un carácter
- **[]**: Nos determina un rango
```bash
# Verificando archivos .txt
# ls *.txt
ls: cannot access '*.txt': No such file or directory
# Creando archivos de prueba
touch archivo1.txt archivo2.txt archivo3.txt
# Enlistando archivos .txt
# ls *.txt
archivo1.txt
archivo2.txt
archivo3.txt
# Enlistando archivos que lleven la palabra 'archivo' y sea seguido de cualquier cadena
# ls archivo*.txt
archivo1.txt
archivo2.txt
archivo3.txt
```

## Tuberías (Pipes)
```bash
# Enumerando archivos del directorio actual
# ls | wc -l
5
# Enumerando archivos incluyendo los ocultos
# la -A | wc -l
5
```

## Redirecciones
- **>**: Sirve para dirigir la salida a un archivo en especifico
- **>>**: Agrega la respuesta en el archivo, NO SOBRESCRIBE
- **<**: Redirige la entrada desde un archivo
- **2>**: Redirige los errores al archivo

## xargs
Procesa los argumentos de salida con comandos dados
```bash
find . -maxdepth 1 -name 'archivo*.txt' -print0 | xargs -0 rm --
# Elimina los archivos del resultdo de buscar todos los archivos .txt que contienen la palabra archivo seguido de algún caracter
```

```bash
find . -name 'archivo*.txt' -exec rm -i {} +
# Elimina los archivos igual que el anterior pero usa el comando -exec rm -i {} + el cual nos pide confirmación para eliminar cada archivo
```

```bash
echo "archivo1.txt archivo2.txt" | xargs rm
# Elimina nuevamente los archivos y toda como parametro los archivos dados con el echo
```

### Comprobación
Para mostrar las líneas enumeradas de un archivo usamos el comando **nl**
```bash
# Creamos un archivo test.txt con 2 líneas con contenido
# nl test.txt
     1	Línea1
     2	Línea2
```
Para contar las líneas de un archivo usamos el comando  **wc -l**
```bash
# wc -l test.txt
2 test.txt
```

## Administración básica