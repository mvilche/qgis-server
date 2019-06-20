#!/bin/bash
set -e
echo "#########################"
echo "MARTIN FABRIZZIO VILCHE"
echo "##############################"

DIR='/home/qgis/.init'

if [ ! -d $DIR ]; then  
mkdir -p /home/qgis/.init /home/qgis/qgisserverdb /home/qgis/qgisserverdb /home/qgis/projects /home/qgis/runtime && \
cp -rf /tmp/world/* /home/qgis/projects/ && \
echo "##############################" && \
echo "DIRECTORIOS INICIALIZADOS.." && \
echo "##############################"
fi



if [ -z "$TIMEZONE" ]; then
echo "···································································································"
echo "VARIABLE TIMEZONE NO SETEADA - INICIANDO CON VALORES POR DEFECTO"
echo "POSIBLES VALORES: America/Montevideo | America/El_Salvador"
echo "···································································································"
else
echo "···································································································"
echo "TIMEZONE SETEADO ENCONTRADO: " $TIMEZONE
echo "···································································································"
echo "SETEANDO TIMEZONE"
cat /usr/share/zoneinfo/$TIMEZONE > /etc/localtime && \
echo $TIMEZONE > /etc/timezone
fi


if [ -z "$QGIS_DOMAIN" ] || [ -z "$QGIS_LOGLEVEL" ] || [ -z "$QGIS_DEBUG" ]; then
echo "##############################"
echo "VARIABLES OBLIGATORIAS NO SETEADAS - REVISE QGIS_DOMAIN, QGIS_LOGLEVEL, QGIS_DEBUG - ERROR SALIENDO"
echo "##############################"
exit 1
fi

if [ "$QGIS_LOGLEVEL" != 0 ] && [ "$QGIS_LOGLEVEL" != 1 ] && [ "$QGIS_LOGLEVEL" != 2 ]; then
echo "##############################"
echo "VALOR ASIGNADO A QGIS_LOGLEVEL NO PERMITIDO"
echo "VALORES VALIDOS: 0,1,2"
echo "##############################"
exit 1
fi

if [ "$QGIS_LOGLEVEL" -eq 1 ]; then
echo "##############################"
echo "SETEANDO QGIS LOG LEVEL EN WARNING "
echo "##############################"
fi

if [ "$QGIS_LOGLEVEL" -eq 0 ]; then
echo "##############################"
echo "SETEANDO QGIS LOG LEVEL EN INFO "
echo "##############################"
fi

if [ "$QGIS_LOGLEVEL" -eq 3 ]; then
echo "##############################"
echo "SETEANDO QGIS LOG LEVEL EN CRITICAL "
echo "##############################"
fi


if [ "$QGIS_DEBUG" != 0 ] && [ "$QGIS_DEBUG" != 1 ]; then
echo "##############################"
echo "VALOR ASIGNADO A QGIS_DEBUG NO PERMITIDO"
echo "VALORES VALIDOS: 0,1"
echo "##############################"
exit 1
fi

if [ "$QGIS_DEBUG" -eq 1 ]; then
echo "##############################"
echo "QGIS MODO DEBUG ACTIVADO"
echo "##############################"
fi








/usr/bin/Xvfb :99 -screen 0 1024x768x24 -ac +extension GLX +render > /dev/null 2>&1 &

pidof Xvfb
if [ $? -eq 0 ]; then
echo "XVFB INICIADO CORRECTAMENTE.."
fi

source envvars
echo "INICIANDO $APP_NAME...."
sleep 5s
exec "$@"
