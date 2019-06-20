# QGIS 3.6 - DOCKER IMAGE

QGIS 3.6 + UBUNTU BIONIC Docker image

## Variables

| Nombre | Descripción   |
|---|---|
| QGIS_DOMAIN  |  Dominio de acceso |
| QGIS_DEBUG  | Activar o desactivar modo debug (Activado: 1 || Desactivado: 0)  |
| QGIS_LOGLEVEL  | Nivel de log (Info: 0 || Warning: 1 || Critical: 2)  |
| TIMEZONE  | Timezon predeterminado (Ejemplo: America/Montevideo )  |


## Iniciar servicios

```bash

docker-compose up

```

## Usage

```bash

Example map:


http://$QGIS_DOMAIN:8082/cgi-bin/qgis_mapserv.fcgi?MAP=/home/qgis/projects/world3.qgs&SERVICE=WMS&VERSION=1.3.0&REQUEST=GetMap&BBOX=-432786,4372992,3358959,7513746&SRS=EPSG:3857&WIDTH=665&HEIGHT=551&LAYERS=countries&FORMAT=image/jpeg

```

## Contribuciones
Son bienvenidas las contribuciones al proyecto


## License
Martin Fabrizzio Vilche
