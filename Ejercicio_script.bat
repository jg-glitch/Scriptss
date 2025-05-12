@echo off
:: Oculta la visualización de los comandos a medida que se ejecutan en la consola.

setlocal enabledelayedexpansion
:: Habilita la expansión retardada de variables

:: Pide al usuario ingresar la configuración de red estática.
set /p IP=Introduce la IP estática:
set /p MASCARA=Introduce la máscara de subred:
set /p PUERTA=Introduce la puerta de enlace:

:: Muestra un mensaje e inicia la configuración de red.
echo Configurando IP...
netsh interface ip set address "Ethernet" static %IP% %MASCARA% %PUERTA%
:: Usa netsh para establecer una IP estática en la interfaz "Ethernet".
echo Configuración aplicada.

:: Solicita las rutas de origen y destino para realizar la copia de archivos.
set /p ORIGEN=Ruta de origen para la copia:
set /p DESTINO=Ruta de destino para la copia:

:: Crea la carpeta de destino si no existe.
if not exist "%DESTINO%" mkdir "%DESTINO%"

:: Inicia el proceso de backup.
echo Iniciando backup...
robocopy "%ORIGEN%" "%DESTINO%" /E /Z /NP /LOG+:log_admin.txt
:: Usa Robocopy para copiar todo el contenido (/E), con capacidad de reanudación (/Z),
:: sin mostrar el progreso por archivo (/NP) y agrega el log en log_admin.txt.

:: Agrega una línea separadora en el log.
echo --- >> log_admin.txt

:: Agrega un log con la configuración de red utilizada.
echo [%DATE% %TIME%] Configuración de red: IP=%IP%, MASK=%MASCARA%, GATEWAY=%PUERTA% >> log_admin.txt

:: Agrega un log con información sobre la copia realizada.
echo [%DATE% %TIME%] Copia realizada de "%ORIGEN%" a "%DESTINO%" >> log_admin.txt

:: Mensaje final indicando que la operación ha terminado.
echo Operación completada. Revisa el archivo log_admin.txt

pause
:: Pausa la ejecución hasta que el usuario presione una tecla.