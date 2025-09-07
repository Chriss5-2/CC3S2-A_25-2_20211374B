# Actividad 3 - Integración de DevOps y DevSecOps con HTTP, DNS, TLS y 12-Factor App

## Parte teórica
- Introducción a DevOps: ¿Qué es y qué no es?/ 
DevOps según mi interpretación es una metodología de trabajo en equipo el cuál se basa principalmente en reemplazar el sistema anterior que se poseía ya que ese sistema, volvía independiente a cada parte del proyecto, por ende los tiempos de producción eran sumamente largos, pero ahora con esta nueva metodología, lo que se hace es mantener una conexión entre las 3 partes de producción para solucionar cualquier error que anteriormente generaria dias o semanas de re producción, pero ahora en corto tiempo se solucionaría para continuar con el proceso.
Proceso de ejecución:
![Img](Img/DevOps.png)


- Marco CALMS en acción: Describe cada pilar y su integración en el laboratorio (ej. Automation con Makefile, Measurement con endpoints de salud). Propón extender Sharing con runbooks/postmortems en equipo./
- Culture: La integración de archivos **Makefile**, **app.py**, **Nginx** sirve para que exista un conjunto de archivos que permite que no haya huecos entre desarrolladores y operadores
- Automation: En el **Makefile** se puede evidenciar este uso ya que con esto poniendo de ejemplo, la instalación de dependencias o creación de entornos virtuales sobre los que trabajar, lo que se haría con varias líneas de código como 
```bash
python -m venv bd
source bd/script/activate
```
En el **Makefile** se reemplazarís con una sola línea
```bash
Make prepare
```
Y así nos ahorramos 2 líneas de código, lo cuál no parece gran cosa en este ejemplo pero en caso sea un script grande como verificaciones de los protocolos HTML, o TLS, en vez de escribir todo el comando, simplemente lo designamos por ejemplo a la tarea **check** en el Makefile y lo corremos con **Make check**
- Lean: En el laboratorio se usa la infraestructura como código para generar un despliegue automatiado lo cuál va a reducir tareas manuales, ganando así velocidad de ejecución y evitar errores, este ejemplo se refleja con **Make run**
- Measurement: En el laboratorio vemos que se usa el **curl** command, lo cuál nos serviría para ejecutar peticiones HTTP, así que con ello, es posible observar métricas, como la latencia, tiempo de conexión, o verificar el mismo código fuente http de la página a buscar para en caso de DevSecOps, buscar errores o vulnerabilidades sobre las cuales sacar proecho
- Sharing: El pilar de compartir, se basa basicamente en la documentación de todos los procesos para así compartir y evidenciar todo lo realizador, para tener una trazabilidad de las acciones hechas en el proyecto y sea más fácil rastrear el origen de las modificaciones, y así al momento de que haya un nuevo integrante, pueda realizar el paso a paso de las modificaciones para poder tener el mismo sistema que todos poseen sin cambio o diferenciación alguna


- Visión cultural de DevOps y paso a DevSecOps: Analiza colaboración para evitar silos, y evolución a DevSecOps (integrar seguridad como cabeceras TLS, escaneo dependencias en CI/CD). Propón escenario retador: fallo certificado y mitigación cultural. Señala 3 controles de seguridad sin contenedores y su lugar en CI/CD.

Tip: Usa el archivo de Nginx y systemd para justificar tus controles.

- Metodología 12-Factor App: Elige 4 factores (incluye config por entorno, port binding, logs como flujos) y explica implementación en laboratorio. Reto: manejar la ausencia de estado (statelessness) con servicios de apoyo (backing services).