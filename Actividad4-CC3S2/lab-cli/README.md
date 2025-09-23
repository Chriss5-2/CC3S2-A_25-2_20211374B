# Actividad4
# **Sección 1: Manejo sólido de CLI**
## Navegación básica
Se ejecutarán pruebas básicas de acuerdo al tipo de comando descrito
### pwd
Muestra el directorio actual en el que nos ubicamos
```bash
#pwd
/workspaces/CC3S2-A_25-2_20211374B/Actividad4-CC3S2/lab-cli
```
### ls
Enlista toTry again? [y/N] Try again? [y/N] info: Removing directory `/home/nuevouser' ...
info: Removing user `nuevouser' ...
info: Removing group `nuevouser' ...
isos que posee cada archivo
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

# **Sección 2: Administración básica**
- **Usuarios/Grupos/Permisos**: Controlan quién accede a qué, previniendo brechas de seguridad (principio de menor privilegio).
- **Procesos/Señales**: Monitorean y controlan ejecuciones, útil para depurar contenedores Docker o pods Kubernetes.
- **systemd**: Gestor de servicios en sistemas modernos como Ubuntu, para iniciar/parar servicios de manera segura.
- **journalctl**: Herramienta de logging para auditar eventos del sistema, esencial en investigaciones de incidentes de seguridad.

## Usuarios/Grupos/Permisos
- **whoami**: Muestra el usuario actual
```bash
codespace
```
- **id**: Muestra la UID, GID y los grupos existentes
```bash
uid=1000(codespace) gid=1000(codespace) groups=1000(codespace),103(docker),986(pipx),987(python),988(oryx),989(golang),990(sdkman),991(rvm),992(php),993(conda),994(nvs),995(nvm),996(hugo),1001(ssh)
```
- Práctica:
```bash
# Creación d enuevo usuario
# sudo adduser nuevouser
info: Adding user `nuevouser2' ...
info: Selecting UID/GID from range 1000 to 59999 ...
info: Adding new group `nuevouser2' (1003) ...
info: Adding new user `nuevouser2' (1003) with group `nuevouser2 (1003)' ...
info: Creating home directory `/home/nuevouser2' ...
info: Copying files from `/etc/skel' ...
Changing the user information for nuevouser2
Enter the new value, or press ENTER for the default
	Full Name []: 	Room Number []: 	Work Phone []: 	Home Phone []: 	Other []: Is the information correct? [Y/n] Is the information correct? [Y/n] info: Adding new user `nuevouser2' to supplemental / extra groups `users' ...
info: Adding user `nuevouser2' to group `users' ...
# Agregando permisos a un archivo
# touch archivo
# chmod 644 archivo
```

## Procesos/señales
```bash
# Listar los procesos
# ps aux
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
codespa+       1  0.0  0.0   1136   640 ?        Ss   06:10   0:00 /sbin/docker-init -- /bin/sh -c echo Container started trap "exit 0" 15 /usr/local/share/ssh-init.sh /usr/local/share/docker-init.sh exec "$@" while sleep 1 & wait $!; do :; done -
codespa+       7  0.0  0.0   2800  1536 ?        S    06:10   0:00 /bin/sh -c echo Container started trap "exit 0" 15 /usr/local/share/ssh-init.sh /usr/local/share/docker-init.sh exec "$@" while sleep 1 & wait $!; do :; done -
root          35  0.0  0.0  12016  2836 ?        Ss   06:10   0:00 sshd: /usr/sbin/sshd [listener] 0 of 10-100 startups
root          58  0.0  0.9 1968036 73276 ?       Sl   06:10   0:00 dockerd --dns 168.63.129.16
root          67  0.0  0.5 1801184 47620 ?       Ssl  06:10   0:00 containerd --config /var/run/docker/containerd/containerd.toml
codespa+     409  0.0  0.0   2800  1792 ?        Ss   06:10   0:00 /bin/sh
root         443  0.0  0.0   2800  1792 ?        Ss   06:10   0:00 /bin/sh
codespa+     584  0.0  0.0   2808  1664 ?        Ss   06:10   0:00 sh /home/codespace/.vscode-remote/bin/0f0d87fa9e96c856c5212fc86db137ac0d783365/bin/code-server --log trace --force-disable-user-env --server-data-dir /home/codespace/.vscode-remote --accept-server-license-terms --host 127.0.0.1 --port 0 --connection-token-file /home/codespace/.vscode-remote/data/Machine/.connection-token-0f0d87fa9e96c856c5212fc86db137ac0d783365 --extensions-download-dir /home/codespace/.vscode-remote/extensionsCache --start-server  --enable-remote-auto-shutdown --skip-requirements-check
codespa+     592  0.7  1.5 11841916 127172 ?     Sl   06:10   0:06 /vscode/bin/linux-x64/0f0d87fa9e96c856c5212fc86db137ac0d783365/node /vscode/bin/linux-x64/0f0d87fa9e96c856c5212fc86db137ac0d783365/out/server-main.js --log trace --force-disable-user-env --server-data-dir /home/codespace/.vscode-remote --accept-server-license-terms --host 127.0.0.1 --port 0 --connection-token-file /home/codespace/.vscode-remote/data/Machine/.connection-token-0f0d87fa9e96c856c5212fc86db137ac0d783365 --extensions-download-dir /home/codespace/.vscode-remote/extensionsCache --start-server  --enable-remote-auto-shutdown --skip-requirements-check
codespa+     614  3.2  4.6 44128452 382116 ?     Sl   06:10   0:28 /vscode/bin/linux-x64/0f0d87fa9e96c856c5212fc86db137ac0d783365/node --dns-result-order=ipv4first /vscode/bin/linux-x64/0f0d87fa9e96c856c5212fc86db137ac0d783365/out/bootstrap-fork --type=extensionHost --transformURIs --useHostProxy=false
codespa+     629  0.0  0.7 1262068 60912 ?       Sl   06:10   0:00 /vscode/bin/linux-x64/0f0d87fa9e96c856c5212fc86db137ac0d783365/node /vscode/bin/linux-x64/0f0d87fa9e96c856c5212fc86db137ac0d783365/out/bootstrap-fork --type=fileWatcher
codespa+    1044  0.2  0.8 1140320 73216 ?       Sl   06:10   0:02 /vscode/bin/linux-x64/0f0d87fa9e96c856c5212fc86db137ac0d783365/node /vscode/bin/linux-x64/0f0d87fa9e96c856c5212fc86db137ac0d783365/out/bootstrap-fork --type=ptyHost --logsPath /home/codespace/.vscode-remote/data/logs/20250923T061034
codespa+    1864  0.0  0.0   2800  1792 ?        Ss   06:10   0:00 /bin/sh
root        1916  0.0  0.0   2800  1664 ?        Ss   06:10   0:00 /bin/sh
codespa+    2158  0.0  0.1  16580 12800 pts/2    Ss   06:10   0:00 /bin/bash --init-file /vscode/bin/linux-x64/0f0d87fa9e96c856c5212fc86db137ac0d783365/out/vs/workbench/contrib/terminal/common/scripts/shellIntegration-bash.sh
codespa+    2530  0.0  0.8 11667644 67284 ?      Sl   06:10   0:00 /vscode/bin/linux-x64/0f0d87fa9e96c856c5212fc86db137ac0d783365/node /vscode/bin/linux-x64/0f0d87fa9e96c856c5212fc86db137ac0d783365/extensions/json-language-features/server/dist/node/jsonServerMain --node-ipc --clientProcessId=614
codespa+    2785  0.2  0.9 1187832 75956 ?       Sl   06:11   0:01 /vscode/bin/linux-x64/0f0d87fa9e96c856c5212fc86db137ac0d783365/node /vscode/bin/linux-x64/0f0d87fa9e96c856c5212fc86db137ac0d783365/extensions/markdown-language-features/dist/serverWorkerMain --node-ipc --clientProcessId=614
codespa+    3617  0.0  0.0   6136  1920 pts/2    S+   06:13   0:00 script -aq evidencias/sesion.txt
codespa+    3618  0.0  0.1  15936 12032 pts/0    Ss   06:13   0:00 bash -i
codespa+   11581  0.0  0.0   6112  1792 ?        S    06:25   0:00 sleep 1
codespa+   11601  0.0  0.0  11456  4224 pts/0    R+   06:25   0:00 ps aux

#Lanzar un monitor interactivo 
top
# Para salir presionar q

# Termina proceso
# kill -SIGTERM PID
# Se debe de cambiar el PID por el proceso
```

## **systemd**
```
# Muestra estado de un servicio
# systemctl status ssh
"systemd" is not running in this container due to its overhead.
Use the "service" command to start services instead. e.g.: 

service --status-all
 [ - ]  dbus
 [ - ]  procps
 [ - ]  rsync
 [ + ]  ssh
 [ - ]  x11-common
```
   - Iniciar/parar: `sudo systemctl start/stop servicio`.
   - Habilitar al boot: `sudo systemctl enable servicio`.
   - Nota para macOS: No hay systemd; usa análogos como `launchctl` o `brew services` (si tienes Homebrew instalado).

## **journalctl**
- `journalctl -u servicio`: Logs de un servicio.
- `journalctl -f`: Sigue logs en tiempo real.
- `journalctl --since "2025-08-29"`: Logs desde una fecha.

## Ejercicios de reforzamiento
```bash
sudo adduser devsec; sudo addgroup ops; sudo usermod -aG ops devsec; touch secreto.txt; sudo chown devsec:ops secreto.txt; sudo chmod 640 secreto.txt

# Ejecución
#@Chriss5-2 ➜ /workspaces/CC3S2-A_25-2_20211374B/Actividad4-CC3S2/lab-cli (main) $ sudo adduser devsec; sudo addgroup ops; sudo usermod -aG ops devsec; touch secreto.txt; sudo chown devsec:ops secreto.txt; sudo chmod 640 secreto.txt >> README.md 
#info: Adding user `devsec' ...
#info: Selecting UID/GID from range 1000 to 59999 ...
#info: Adding new group `devsec' (1006) ...
#info: Adding new user `devsec' (1006) with group #`devsec (1006)' ...
#info: Creating home directory `/home/devsec' ...
#info: Copying files from `/etc/skel' ...
#New password: 
#Retype new password: 
#passwd: password updated successfully
#Changing the user information for devsec
#Enter the new value, or press ENTER for the default
#        Full Name []: devsec
#        Room Number []: 1
#        Work Phone []: 1
#        Home Phone []: 1
#        Other []: 
#Is the information correct? [Y/n] Y
#info: Adding new user `devsec' to supplemental / #extra groups `users' ...
#info: Adding user `devsec' to group `users' ...
#info: Selecting GID from range 1000 to 59999 ...
#info: Adding group `ops' (GID 1007) ...

# Listando procesos
codespa+    2158  0.0  0.1  16580 12800 pts/2    Ss   06:10   0:00 /bin/bash --init-file /vscode/bin/linux-x64/0f0d87fa9e96c856c5212fc86db137ac0d783365/out/vs/workbench/contrib/terminal/common/scripts/shellIntegration-bash.sh
codespa+    3618  0.0  0.1  16724 12928 pts/0    Ss   06:13   0:00 bash -i
codespa+   18609  0.0  0.0   7080  2176 pts/0    S+   06:35   0:00 grep --color=auto bash

# Creando y matando un proceso
# sleep 100 &
[2] 19518
# Listando los procesos
# ps    PID TTY          TIME CMD
   3618 pts/0    00:00:00 bash
  14323 pts/0    00:00:00 nc
  19518 pts/0    00:00:00 sleep
  19746 pts/0    00:00:00 ps
# Matando el proceso --> PID:19518
# kill 19518 >> README.md
[2]+  Terminated              sleep 100
```

## Comprobación
```bash
# Verificación de permisos y propietario de un archivo
# namei -l secreto.txt
f: secreto.txt
-rw-r----- devsec ops secreto.txt
# Confirmación de un grupo existente
# id devsec
uid=1006(devsec) gid=1006(devsec) groups=1006(devsec),100(users),1007(ops)
```

# **Sección 3: Utilidades de texto de Unix**
## Herramientas para el procesado de datos
- **grep**: Busca patrones en texto
```bash
# Creación de archivo con 3 líneas
echo "Hola 1" >> greep.txt
echo "Chau 1" >> greep.txt
echo "Hola 2" >> greep.txt
# Buscando patrones de datos
# grep Hola greep.txt
Hola 1
Hola 2
# grep Chau greep.txt
Chau 1
```
- **sed**: Edición de textos como sustituir o eliminar
```bash
# Sustituyendo Hola por hola
# sed "s/Hola/hola/" greep.txt
hola 1
Chau 1
hola 2
```
- **awk**: Procesa datos estructurales
```bash
# Mostrando solo la primera palabra de cada línea
# awk "{print $1} greep.txt
Hola
Chau
Hola
# Mostrando primera y segunda columna separado por una coma
# awk '{print $1 "," $2}' greep.txt
Hola,1
Chau,1
Hola,2
# Esto sirve cuando queremos tratar datos y les queremos dar formato de .csv
```
- **cut**: Extrae campos
```bash
# Mostrando desde el 1er caracter al 3 caracter
# cut -c1-3 greep.txt
Hol
Cha
Hol
```
- **sort/uniq**: Ordena y elimina duplicados
```bash
# Archivo inicial
# cat greep.txt
Hola 1
Chau 1
Hola 2
# Ordenando por orden alfabetico
# sort greep.txt
Chau 1
Hola 1
Hola 2
# Ordenar de manera inversa
# sort -r greep.txt
Hola 2
Hola 1
Chau 1
# Elimina duplicados consecutivos
# echo "Hola 1" >> greep.txt
# echo "Hola 1" >> greep.txt
# cat greep.txt
Hola 1
Chau 1
Hola 2
Hola 1
Hola 1
# uniq greep.txt
Hola 1
Chau 1
Hola 2
Hola 1
# Verificar ocurrencia de líneas
# uniq -c greep.txt
      1 Hola 1
      1 Chau 1
      1 Hola 2
      2 Hola 1
```
- **tr**: Traduce carácteres
```bash
# Leer el archivo y cambiar de H a h
# cat greep.txt | tr 'H' 'h'
hola 1
Chau 1
hola 2
hola 1
hola 1
```
- **tee**: Divide salidas a múltiples destinos
```bash
# Mostrar greep.txt y guardar en salida.txt
# cat greep.txt | tee salida.txt
Hola 1
Chau 1
Hola 2
Hola 1
Hola 1
# Verificación de creación del archivo salida.txt
README.md
archivo
archivo1.txt
archivo2.txt
archivo3.txt
errores.log
evidencias
greep.txt
mockuser
salida.txt
secreto.txt
test.txt
tmp_lista
```
- **find**: Buscar archivos por criterios
```bash
# Buscando archivo greep.txt
/workspaces/CC3S2-A_25-2_20211374B/Actividad4-CC3S2/lab-cli/greep.txt
# Buscando archivo salida.txt
/workspaces/CC3S2-A_25-2_20211374B/Actividad4-CC3S2/lab-cli/salida.txt
# De paso así es más facil verficiar la existencia de algunos archivos
```

### Creación de archivo de prueba
```bash
# printf "linea1: dato1\nlinea2: dato2\n" > datos.txt
linea1: dato1
linea2: dato2
```

### Ejercicios de reforzamiento
- grep para buscar root en /etc/passwd
```bash
#grep root /etc/passwd
root:x:0:0:root:/root:/bin/bash
```
- sed para sustitui dato1 por secreto en datos.txt
```bash
# sed 's/dato1/secreto/' datos.txt > nuevo.txt
linea1: secreto
linea2: dato2
```
- awk y cut para extraer los usuarios de /etc/passwd
```bash
# awk -F: '{print $1}' /etc/passwd | sort | uniq
_apt
backup
bin
codespace
daemon
devsec
games
irc
list
lp
mail
man
messagebus
news
nobody
nuevouser
nuevouser2
polkitd
proxy
root
sshd
sync
sys
systemd-network
uucp
www-data
```
- tr para convertir un texto a mayúsculas y tee para guardarlo en el archivo mayus.txt
```bash
# printf "hola\n" | tr 'a-z' 'A-Z' | tee mayus.txt
HOLA
```
- Encontrar archivos en /tmp modificados en los últimos 5 días
```bash
# find /tmp -mtime -5 -type f
/tmp/dockerd.log
/tmp/storage_version.txt
/tmp/codespaces_logs/20250923_061042_17586078423710_VSCode.log
/tmp/sshd.log
```
- Pipeline completo
```bash
# ls /etc | grep conf | sort | tee lista_conf.txt | wc -l
24
```
- Auditar con tee
```bash
[?2004h[0;32m@Chriss5-2 [0m➜ [1;34m/workspaces/CC3S2-A_25-2_20211374B/Actividad4-CC3S2/lab-cli [0;36m([1;31mmain[0;36m) [0m$ [7mls noexiste 2>> errores.log[27mls noexiste 2>> errores.log
	[31merrores.log[m
	[32mnew file:   errores.log[m
 create mode 100644 Actividad4-CC3S2/lab-cli/errores.log
passwd: Authentication token manipulation error
fatal: `groupdel nuevouser' returned error code 6. Exiting.
archivo    archivo2.txt  errores.log   greep.txt   salida.txt  test.txt
```

### Comprobación
- Verificar el tipo de dato y contenido
```bash
# file lista_conf.txt && head lista_conf.txt
adduser.conf
ca-certificates.conf
debconf.conf
deluser.conf
e2scrub.conf
gai.conf
gitconfig
host.conf
ld.so.conf
ld.so.conf.d
```
- Verificar el cambio a mayúscuas realizado
```bash
# cat mayus.txt
HOLA
```

# Finalización de Actividad 4