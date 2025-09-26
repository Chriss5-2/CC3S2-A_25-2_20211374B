# Actividad 6: Introducción a Git conceptos básicos y operaciones esenciales

## Conceptos básicos de Git: Comienza con una experiencia práctica

### Git config:
El git config sirve para configurar a Git en base al usuario y repositorio que se usará, el nivel system es para todos los usuarios, el global aplica para los repositorios de un usuario en específico y local aplica a un solo repositorio, los comandos para configurar son:
```bash
# Configurar nombre de usuario
git config --global user.name "<name>"
# Configurar email del usuario
git config --global user.email "<email>"
```
Luego de configurar, para verificar los datos ingresados, podemos usar **git --list** para revisar el registro de configuración:
```bash
user.name=Christian Luna Jaramillo
user.email=65150753+Chriss5-2@users.noreply.github.com
<...output>
```

### Git init:
El comando **git init** permite la inicialización d eun nuevo repositorio de Git para mantener un registro de los cambios realizados en el repositorio. 

```bash
# Creación de repositorio
# mkdir criz-repo
# cd criz-repo
# git init
Initialized empty Git repository in /workspaces/CC3S2-A_25-2_20211374B/Actividad6-CC3S2/criz-repo/.git/
```

Otra forma de crear el repositorio es con el comando **git init criz-repo**:
```bash
# cd ..
# rm -rf criz-repo
# git init criz-repo
Initialized empty Git repository in /workspaces/CC3S2-A_25-2_20211374B/Actividad6-CC3S2/criz-repo/.git/
# Verificando creación del repositorio criz-repo
# ls
README.md
criz-repo
```
Inicializar el repositorio de esa forma, nos ahorra el trabajo de crear una carpeta y luego inicializarla.

La forma básica de verificar que estamos en un repositorio, será la existencia del archivo **.git** en le carpeta del repositorio
```bash
# Usamos -al porque el directorio .git es un archivo oculto
# ls -al
total 12
drwxrwxrwx+ 3 codespace codespace 4096 Sep 26 16:16 .
drwxrwxrwx+ 3 codespace codespace 4096 Sep 26 16:16 ..
drwxrwxrwx+ 6 codespace codespace 4096 Sep 26 16:16 .git
```

### Git add
Para guardar los archivos creados y modificaciones realizadas, se usará el comando **git add** el cuál hará que se almacenen en el repositorio de Git, y al momento de guardar estos cambios, Git los hace formar parte del historial y los alista para ser commiteados y guardados en el repositorio.
```bash
# Ingresamos al repositorio
# cd criz-repo
# Creamos archivo README.md con la línea " README"
# echo " README" > README.md
```
Luego de realizar estos cambios, para verificar el estado de las modificaciones podemos usar el comando **git status**
```bash
# git status
On branch main

No commits yet

Untracked files:
  (use "git add <file>..." to include in what will be committed)
	README.md

nothing added to commit but untracked files present (use "git add" to track)
# La respuesta nos indica que se modifico el archivo README.md pero aún no se agrega, por eso que se dice que el archivo README.md está en untracked el cual indica que aúnno está siendo rastreado por Git, para cambiar este estado por uno rastreado, lo agregamos a Git con el comando git add
# git add . o git add README.md
# git status
On branch main

No commits yet

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)
	new file:   README.md
```
Para agregar todos los archivos de una extensión en particular, podemos usar **git add *.txt** que agrega todos los archivos **.md** que no están siendo rastreados

### Git commit
Luego de hacer un seguimiento de los archivos con **git add**, para registrar los cambios de estos archivos, usamos el comando **git commit** para rastrearlos por más tiempo, el **git commit** sirve como para tener un punto de control donde guardamos todos los cambios hechos hasta el momento, y en caso querramos regresar a estos cambios, se puede hacer a partir de ese commit creado.
```bash
# git commit -m "Commit inicial con README.md"
[main (root-commit) 99f1448] Commit inicial con README.md
 1 file changed, 1 insertion(+)
 create mode 100644 README.md
# git status
On branch main
nothing to commit, working tree clean
# Podemos ver que luego de realizar git commit, ahora se guardaron todos los cambios delos que se tenía seguimiento, y ahora nuestra rama no tiene archivo sin guardar, basicamente establecimos nuestro punto de control desde ese punto
```

### Git log
Cuando se realizan los commits, la forma de identificarlos es a través de su **HASH** y git, mantiene un historial todos estos **commits**, llamando al commit anterior a uno, **commit padre** y los que siguen después **commits hijos**, para verificar este historial de commits, podemos usar **git log** el cuál nos mostrará el historia de commit desde el commit más actual al más antiguo
```bash
# git log
commit 99f144804546b580e40b9b1e0810d722dd086873
Author: Christian Luna Jaramillo <65150753+Chriss5-2@users.noreply.github.com>
Date:   Fri Sep 26 17:19:11 2025 +0000

    Commit inicial con README.md
# Podemos ver que en el historial aparece el commit hecho anteriormente, y además de eso nos indica en primero lugar, su hash, la rama, el autor, la fecha y el mensaje
# hash: 99f144804546b580e40b9b1e0810d722dd086873
# rama: Christian Luna Jaramillo
# autor: <no aparece porque aún no hacemos git push>
# fecha: Fri Sep 26 17:19:11 2025 +0000
# mensaje: Commit inicial con README.md
```
Cabe recalcar, que el **HASH** del **commit** es **ÚNICO**, ya que este **HASH** se encarga de describir lo que contiene el commit hasta ese momento

#### Variaciones de git log
- **git log -p**: Muestra la diferencia entre cada commit
```bash
# git log -p
commit 99f144804546b580e40b9b1e0810d722dd086873
Author: Christian Luna Jaramillo <65150753+Chriss5-2@users.noreply.github.com>
Date:   Fri Sep 26 17:19:11 2025 +0000

    Commit inicial con README.md

diff --git a/README.md b/README.md
new file mode 100644
index 0000000..e845566
--- /dev/null
+++ b/README.md
@@ -0,0 +1 @@
+README
```

- **git log --stat**: Proporciona más detalles de cada commit
```bash
# git log --stat
commit 99f144804546b580e40b9b1e0810d722dd086873
Author: Christian Luna Jaramillo <65150753+Chriss5-2@users.noreply.github.com>
Date:   Fri Sep 26 17:19:11 2025 +0000

    Commit inicial con README.md

 README.md | 1 +
 1 file changed, 1 insertion(+)
```

- **git log --oneline**: Da una salida más compacta del historial de commits donde solo se muestra el **HASH** resumido en sus primeros **8 dígitos** y el mensaje del commit
```bash
# git log --oneline
99f1448 Commit inicial con README.md
# Hash original: 99f144804546b580e40b9b1e0810d722dd086873
```

- **git log --graph**: Permite la visualización del historial donde nos muestra el historial de las **ramas** y los **merge** realizados en un gráfico **ASCII**
```bash
# git log --graph
* commit 99f144804546b580e40b9b1e0810d722dd086873
  Author: Christian Luna Jaramillo <65150753+Chriss5-2@users.noreply.github.com>
  Date:   Fri Sep 26 17:19:11 2025 +0000
  
      Commit inicial con README.md
```
Podemos ver que nos muestra una salida similar al historial anterior, pero en lo que varía, es que se puede apreciar que al comiendo de la descripción del commit, aparece un '*' el cuál es el punto de referencia para ver que estamos en un gráfico, y mientras más commits hayan, estos * se irán conectando y formarán el grafo

- **git log --author="Christian Luna Jaramillo"**: Filtra los commits de acuerdo a un autor en específico
```bash
# git log --author="Christian Luna Jaramillo"
commit 99f144804546b580e40b9b1e0810d722dd086873
Author: Christian Luna Jaramillo <65150753+Chriss5-2@users.noreply.github.com>
Date:   Fri Sep 26 17:19:11 2025 +0000

    Commit inicial con README.md
```

- **git log --graph --pretty=format:'%x09 %h %ar ("%an") %s'**: Nos muestra un historial pero filtrando datos, el comando indica que nos lo muestre el formato de **grafo**, que nos indique el **HASH**, el **tiempo** de diferencia, **autor** y el **mensaje**
```bash
# git log --graph --pretty=format:'%x09 %h %ar ("%an") %s'
* 	 99f1448 20 minutes ago ("Christian Luna Jaramillo") Commit inicial con README.md
```

##### Creando archivo de trazabilidad de commits
Para esto crearemos un archivo **CONTRIBUTING.md** en el repositorio, y luego lo agregaremos al historial del repositorio
```bash
# echo " CONTRIBUTING" > CONTRIBUTING.md
# echo " README\n\nBienvenido al proyecto" > README.md
# git add .
# git status
On branch main
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
	new file:   CONTRIBUTING.md
	modified:   README.md
# git commit -m "Configura la documentación base del repositorio"
[main 7ec19be] Configura la documentación base del repositorio
 2 files changed, 2 insertions(+), 1 deletion(-)
 create mode 100644 CONTRIBUTING.md

# Agregando código simple en python
# echo "print('Hello World')" > main.py
# git add .
# git commit –m "Agrega main.py"
[main f1205da] Agrega main.py
 1 file changed, 1 insertion(+)
 create mode 100644 main.py

# Verificando en el log el registro del commit
# git log --oneline
f1205da Agrega main.py
7ec19be Configura la documentación base del repositorio
99f1448 Commit inicial con README.md
```

## Trabajar con ramas
La creación de ramas, sirve para crear modificaciones en paralelo, y luego fusionar estas ramas para mezclar los cambios, permitiendo que en equipos de trabajo, cada uno maneje su rama, y al final junte sus cambios para avanzar con un proyecto mucho más rápido que trabajar en una misma rama

### Git branch
La rama principal al crear un repositorio de Git es la rama **main** o en algunos casos se conoce como la rama **master**, para verificar las ramas existentes en el repositorio, usamos el comando **git branch** el cual nos lista todas las ramas del repositorio
```bash
# git branch
* main
```

Para crear una nueva rama, se usa el comando **git branch <nombre_rama>**
```bash
# git branch feature/new-feature
# git branch
  feature/new-feature
* main
# Ahora podemos ver que al listar las ramas, aparece la principal y la nueva rama que se creó con el comando anterior
```

#### Convenciones de nombre de ramas:
La forma estándar es mantener el nombre de la rama con una descripción específica
- **feature/<descripcion>**: Añadir característica
- **bugfix/<descripcion>**: Corregir errores
- **hotfix/<descripcion>**

Al momento de crear ramas, también podemos hacerlo a partir de una rama en específico, o a partir de un commit, donde en este segundo es necesario especificar el **HASH** del commit sobre queremos que parta la rama
```bash
# git branch
  feature/new-feature
* main
# Creando rama a partir de la rama feature/new-feature
# git branch feature/new-feature-2 feature/new-feature
# git branch
  feature/new-feature
  feature/new-feature-2
* main

# git log --oneline
f1205da Agrega main.py
7ec19be Configura la documentación base del repositorio
99f1448 Commit inicial con README.md
# Creando rama a partir del commit con hash 7ec19be
# git branch feature/commit-7ec19be 7ec19be
# git branch
  feature/commit-7ec19be
  feature/new-feature
  feature/new-feature-2
* main
```

### Git checkout / Git switch
Para poner cambiar entre ramas o volver al punto de un commit en específico, se usan los comandos **git checkout <branch_name/commit_hash>** y de esta manera, ubicaremos el **HEAD** a la rama o al commit donde lo creamos
```bash
# Cambiar a la rama feature/new-feature
# git checkout feature/new-feature
Switched to branch 'feature/new-feature'
# git branch
  feature/commit-7ec19be
* feature/new-feature
  feature/new-feature-2
  main


# Para crear y cambiar a una nueva rama
# git checkout -b feature/another-new-feature
Switched to a new branch 'feature/another-new-feature'
# El cuál reemplaza a los dos comandos
# git branch feature/another-new-feature
# git checkout feature/another-new-feature

# Cambiando de rama usando git switch
# git switch -c feature/another-new-feature_2
Switched to a new branch 'feature/another-new-feature_2'
# git branch
  feature/another-new-feature
* feature/another-new-feature_2
  feature/commit-7ec19be
  feature/new-feature
  feature/new-feature-2
  main
```

### Git merge <branch_name>
Para fusionar las ramas se usa el comando **git merge** esto permite unir ambas ramas y guardar los cambios de una sobre otra
```bash
# git checkout main
Switched to branch 'main'

# git merge feature/new-feature
Already up to date.
```
De esta forma, se fusionan los diferentes historiales pero esto se puede complicar en caso los cambios en paralelo afecten a archivos iguales, con lo que generaría error de fusión y se requiere la intervención manual para resolver estos conflictos

### Git branch -d
Para eliminar las ramas, se usa el comando **git branch -d <branch_name>** y así podemos borrar la rama que ya se fusionó
```bash
# Eliminar rama local
# git branch -d feature/new-feature
Deleted branch feature/new-feature (was f1205da).
```

## Preguntas
- ¿Cómo te ha ayudado Git a mantener un historial claro y organizado de tus cambios? 
```bash
Git mantiene un historial claro, gracias al guardado de commit que posee y sus herramientas para vovler a un punto de control en específico, esto ayuda para tener una trazabilidad de todo lo realizado y así poder tener un orden de los cambios
``` 
- ¿Qué beneficios ves en el uso de ramas para desarrollar nuevas características o corregir errores?  
```bash
El uso de ramas para agregar características o corrregir errores, sirve para trabajar en una rama que no afecte a la principal, es decir si tenemos un servicio que corre sobre la rama la main, crear una rama paralela sirve para no afectar a la rama main con los errores que podrían generarse al agregar esas nuevas ramas, así se nos permite agregar y modificar cosas del código fuente para luego en caso todo sea positivo, fusionar las ramas o si la nueva funcionalidad no cumple con lo esperado, eliminamos la rama y nos ahorramos todos los errores
```
- Realiza una revisión final del historial de commits para asegurarte de que todos los cambios se han registrado correctamente.  
- Revisa el uso de ramas y merges para ver cómo Git maneja múltiples líneas de desarrollo.
```bash
En el hstorial de commit, podemos verificar que al realizar un merge entre ramas, se evidencia la unión de estas de acuerdo a la rama a la que pertenecen los commits, y estas uniones varían de acuerdo a que tipo de merge usemos, git merge, git merge --no-ff, o git merge --squash
```

## Ejecicios
### Ejercicio 1: Manejo avanzado de ramas y resolución de conflictos
```bash
# craer la rama feature/advanced-feature y ubicarnos en ella
# git branch feature/advanced-feature
# git checkout feature/advanced-feature
# git branch
* feature/advanced-feature
  feature/another-new-feature
  feature/another-new-feature_2
  feature/commit-7ec19be
  feature/new-feature-2
  main
# Modificamos el archivo main.py en la nueva rama
# Añadimos y guardamos los cambios en la rama
# git add main.py
# git commit -m "Agrega la funcion greet como función avanzada"
[feature/advanced-feature e327543] Agrega la funcion greet como función avanzada
 1 file changed, 4 insertions(+), 1 deletion(-)

# Cambiar a la rama main
# git checkout main
Switched to branch 'main'
# Editamos en archivo main.py de forma distinta a la rama anterior y guardamos los cambios
# git add main.py
# git commit -m "Actualizar el mensaje main.py en la rama main"
[main fd8c9b2] Actualizar el mensaje main.py en la rama main
 1 file changed, 1 insertion(+), 1 deletion(-)

# Fusionando la rama feature/advanced-feature a main
# git merge feature/advanced-feature
Auto-merging main.py
CONFLICT (content): Merge conflict in main.py
Automatic merge failed; fix conflicts and then commit the result.
# Vemos que aparece un conflicto en el merge, y esto se debe a que se modificaron las mismas líneas del archivo main.py y Git no sabe con que cambio quedarse
# Para resolver estos errores es necesario arreglar el conflicto manualmente
# Primero veremos el archivo main.py el cuál nos indica el conflicto
# cat main.py
<<<<<<< HEAD
print('Hello World-actualiado en main')
=======
def greet():
    print('Hello como una función avanzada')

greet()
>>>>>>> feature/advanced-feature
# Podemos ver que nos indica los errores de la rama donde se encontraba HEAD y el que tiene la rama feature/advanced-feature
# Para arreglar estos errores, lo que tenemos que hacer es eliminar los simbolos <<<<<<<, =======, >>>>>>> y luego añadir nuevamente el archivo y commitear los cambios
# Al arreglar el archivo nos tendría que quedar de la siguiente manera
# cat main.py
print('Hello World-actualiado en main')
def greet():
    print('Hello como una función avanzada')

greet()
# Luego de eso ya agregamos y confirmamos los cambios
# git add main.py
# git commit 
# git commit -m "Resuelve el conflicto de fusión entre la versión main y feature/advanced-feature"
[main e04408d] Resuelve el conflicto de fusión entre la versión main y feature/advanced-feature
# Por último eliminamos la rama que fusionamos ya que no queremos sus cambios
# git branch -d feature/advanced-feature
Deleted branch feature/advanced-feature (was e327543).
```

### Ejercicio 2: Exploración y manipulación del historial de commits
Para este ejercicio navegaremos en los commits y manipularemos el historial de Git por medio de comandos
```bash
# echo "Linea prueba" >> README.md
# git add README.md
# git commit -m "Agregando linea de prueba en README.md"
# Ver el historial de commits con detalles
# git log -p
commit 23222762b6a5f92ec2dacda8d4d31f2267e1d465
Author: Christian Luna Jaramillo <65150753+Chriss5-2@users.noreply.github.com>
Date:   Fri Sep 26 18:45:43 2025 +0000

    Agregando linea de prueba en README.md

diff --git a/README.md b/README.md
index e3ff6c4..bd8ccfc 100644
--- a/README.md
+++ b/README.md
@@ -1 +1,2 @@
  README\n\nBienvenido al proyecto
+Linea prueba

commit e04408d0da2184e56d431adad6e6375480f63024
Merge: fd8c9b2 e327543
Author: Christian Luna Jaramillo <65150753+Chriss5-2@users.noreply.github.com>
Date:   Fri Sep 26 18:39:15 2025 +0000

    Resuelve el conflicto de fusión entre la versión main y feature/advanced-feature

commit fd8c9b2f1ce6e58f9589e90c6f988f874d3971a6
Author: Christian Luna Jaramillo <65150753+Chriss5-2@users.noreply.github.com>
Date:   Fri Sep 26 18:34:20 2025 +0000

    Actualizar el mensaje main.py en la rama main

diff --git a/main.py b/main.py
index df1dc68..de168c1 100644
--- a/main.py
+++ b/main.py
@@ -1 +1 @@
-print('Hello World')
+print('Hello World-actualiado en main')

commit e3275434048c93aa5ace8323edd6839e495d5502
Author: Christian Luna Jaramillo <65150753+Chriss5-2@users.noreply.github.com>
Date:   Fri Sep 26 18:32:13 2025 +0000

    Agrega la funcion greet como función avanzada

diff --git a/main.py b/main.py
index df1dc68..7a27f24 100644
--- a/main.py
+++ b/main.py
@@ -1 +1,4 @@
-print('Hello World')
+def greet():
+    print('Hello como una función avanzada')
+
+greet()
\ No newline at end of file

commit f1205da4135c91eb0419691ae5bef0456c09bd0a
Author: Christian Luna Jaramillo <65150753+Chriss5-2@users.noreply.github.com>
Date:   Fri Sep 26 17:44:32 2025 +0000

    Agrega main.py

diff --git a/main.py b/main.py
new file mode 100644
index 0000000..df1dc68
--- /dev/null
+++ b/main.py
@@ -0,0 +1 @@
+print('Hello World')

commit 7ec19be2efb4b813ff60bccfab7a68d78a387a65
Author: Christian Luna Jaramillo <65150753+Chriss5-2@users.noreply.github.com>
Date:   Fri Sep 26 17:43:02 2025 +0000

    Configura la documentación base del repositorio

diff --git a/CONTRIBUTING.md b/CONTRIBUTING.md
new file mode 100644
index 0000000..2e8cc63
--- /dev/null
+++ b/CONTRIBUTING.md
@@ -0,0 +1 @@
+ CONTRIBUTING
diff --git a/README.md b/README.md
index e845566..e3ff6c4 100644
--- a/README.md
+++ b/README.md
@@ -1 +1 @@
-README
+ README\n\nBienvenido al proyecto

commit 99f144804546b580e40b9b1e0810d722dd086873
Author: Christian Luna Jaramillo <65150753+Chriss5-2@users.noreply.github.com>
Date:   Fri Sep 26 17:19:11 2025 +0000

    Commit inicial con README.md

diff --git a/README.md b/README.md
new file mode 100644
index 0000000..e845566
--- /dev/null
+++ b/README.md
@@ -0,0 +1 @@
+README
```

Para revertir un commit, usaremos **git revert HEAD**
```bash
# Revertiremos el último cambio hecho en README.md
# git revert HEAD
# Luego podemos confirmar que se revirtió el cambio
```

Para combinar commits, usamos git rebase interactivo con **git rebase -i HEAD~3**
```bash
# git rebase -i HEAD~3
```

### Ejercicio 3: Creación y gestión de ramas desde commit específicos
Este ejercicio se basa en lo hecho anteriormente de crear una rama, modificar un archivo, volver al main y hacer un merge

### Ejecicio 4: Manipulación y restauración de commits con git reset y git restore
Para esto agregaremos la línea:
    print('Este cambio se restablecerá')
En el archivo main.py añadiremos y confirmaremos los cambios

Usaremos git reset para volver al estado anterior
```bash
# cat main.py
print('Hello World-actualiado en main')
def greet():
    print('Hello como una función avanzada')

greet()

print('Este cambio se restablecerá')

# Usaremos git reset para deshacer el commit
# git log --oneline
ba87361 Introduce un cambio para restablecer
400d049 Revert "Agregando linea de prueba en README.md"
2322276 Agregando linea de prueba en README.md
e04408d Resuelve el conflicto de fusión entre la versión main y feature/advanced-feature
fd8c9b2 Actualizar el mensaje main.py en la rama main
e327543 Agrega la funcion greet como función avanzada
f1205da Agrega main.py
7ec19be Configura la documentación base del repositorio
99f1448 Commit inicial con README.md

# git reset --hard HEAD~1
HEAD is now at 400d049 Revert "Agregando linea de prueba en README.md"

# gir log --oneline
400d049 Revert "Agregando linea de prueba en README.md"
2322276 Agregando linea de prueba en README.md
e04408d Resuelve el conflicto de fusión entre la versión main y feature/advanced-feature
fd8c9b2 Actualizar el mensaje main.py en la rama main
e327543 Agrega la funcion greet como función avanzada
f1205da Agrega main.py
7ec19be Configura la documentación base del repositorio
99f1448 Commit inicial con README.md

# Notamos que el commit no aparece, como si no lo hubieramos guardado
```

Ahora usaremos **git restore** para deshacer cambios que no han sido confirmados, por ende modificaremos el archivo [README.md](criz-repo/README.md), solo modificaremos, no haremos **git add README.md**
```bash
# Modificando README.md
# echo "Linea a deshacer" >> README.md
# cat README.md
 README\n\nBienvenido al proyecto
Linea a deshacer
# git status
On branch main
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   README.md

no changes added to commit (use "git add" and/or "git commit -a")
# Ahora anularemos esa modificación no guardada usando git restore <file_path>
# git restore README.md
# git status
On branch main
nothing to commit, working tree clean
```
Con esto verificamos que se anuló la modificación no guardado, y digo esto porque no hemos hecho **git add README.md** ni y en **git status** aparece que no hay modificación, por ende, el **git restore README.md** hizo que el archivo **README.md** vuelva a su estado original antes de la modificación, por eso que al verificar el estado, se ve que no hay modificación con el archivo original

### Ejercicio 5: Trabajo colaborativo y manejo de Pull Requests
Para esta parte, es tener un repositorio GitHub clonado localmente, y lo que se hará será que haremos **git push origin <branch_name>** y luego en la sección de **Pull Requests** crearemos un nuevo PR y haremos merge a las ramas que queremos fusionar, al finalizar el mismo GitHub nos muestra la opción para eliminar la rama que se creó y ya se fusionó y con eso terminaría toda la acción de Pull Request

### Ejercicio 6: Cherry-Picking y Git Stash
El **cherry-pick** en git sirve para en palabras simples, copiar commits específicos de una rama, a otra sin la necesidad de fusionar la rama entera la cual trae la ventaja de solo implementar cambios que deseamos y no traer todos los cambios realizados
```bash
# Modificamos main.py en la rama main
# echo 'print("Cherry pick!")' >> main.py
# git add main.py
# git commit -m "Agrega ejemplo de cherry-pick"
[main c75db26] Agrega ejemplo de cherry-pick
 1 file changed, 1 insertion(+)
# git log --oneline
c75db26 Agrega ejemplo de cherry-pick
400d049 Revert "Agregando linea de prueba en README.md"
2322276 Agregando linea de prueba en README.md
e04408d Resuelve el conflicto de fusión entre la versión main y feature/advanced-feature
fd8c9b2 Actualizar el mensaje main.py en la rama main
e327543 Agrega la funcion greet como función avanzada
f1205da Agrega main.py
7ec19be Configura la documentación base del repositorio
99f1448 Commit inicial con README.md

# Creamos una rama feature/cherry-pick
# git checkout -b feature/cherry-pick
Switched to a new branch 'feature/cherry-pick'
# git cherry-pick 2322276
[feature/cherry-pick db26081] Agregando linea de prueba en README.md
 Date: Fri Sep 26 18:45:43 2025 +0000
 1 file changed, 1 insertion(+)
# git log --oneline
db26081 Agregando linea de prueba en README.md
c75db26 Agrega ejemplo de cherry-pick
400d049 Revert "Agregando linea de prueba en README.md"
2322276 Agregando linea de prueba en README.md
e04408d Resuelve el conflicto de fusión entre la versión main y feature/advanced-feature
fd8c9b2 Actualizar el mensaje main.py en la rama main
e327543 Agrega la funcion greet como función avanzada
f1205da Agrega main.py
7ec19be Configura la documentación base del repositorio
99f1448 Commit inicial con README.md
# Ahora modificaremos el archivo main.py sin cofirmar los cambios
# echo "Este cambio está en el stash" >> main.py
# git status
On branch feature/cherry-pick
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   main.py

no changes added to commit (use "git add" and/or "git commit -a")
# El objetivo de git stash, es NO agregar los cambios, sino guardarlos temporalmente, y para eso se usa git stash
# git stash
Saved working directory and index state WIP on feature/cherry-pick: db26081 Agregando linea de prueba en README.md
# git status
On branch feature/cherry-pick
nothing to commit, working tree clean
# Cuando querramos aplicar el cambio realizado, lo hacemos con git stash pop
# git stash pop
On branch feature/cherry-pick
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   main.py

no changes added to commit (use "git add" and/or "git commit -a")
Dropped refs/stash@{0} (20b91602f076e77ef11450c46a91449775e1af3a)
# git status
On branch feature/cherry-pick
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   main.py

no changes added to commit (use "git add" and/or "git commit -a")
# git add main.py
# git commit -m "Aplicando git stash"