# Prueba para entrar a Cumplo
En este documento, explicare los archivos que se han cambiado respecto a la estructura original de un proyecto en RoR.
El proyecto esta orientados a `API`, por lo cual no contiene Vistas. Al mismo tiempo fue iniciado, para usarse en `Postgresql`, de igual manera puede usarse en `Mysql2`, agregando la gema y el adaptador.
Este proyecto fue creado, para ser desplegado en Cloud Run, mediante CI/CD desde GCP, por lo cual no es necesario ningún archivo .yml en el, debido a que se proporciona en el mismo Cloud Run.


## Requisitos
Para instalar el proyecto localmente, se requiere tener instalado los siguientes componentes:
* Base de datos `Postgresql 12 ` o superior 
* Debes tener instalado `Rails 5.2.4 ` (Solo necesarios para migración)
* Debes tener instalado `Ruby 2.6.6 `, (Solo necesarios para migración)
* `Docker `, para poder correr el contendor.

## Instalacion

* Debemos correr los comandos para crear las base de datos de test y de producción con los siguientes comandos:

``` sh
rails db:create RAILS_ENV=test
rails db:migrate RAILS_ENV=test
rails db:create RAILS_ENV=production
rails db:migrate RAILS_ENV=production
```
Recuerda cambiar el archivo config/database.yml, tanto los default username y password, como los username y password de producción, que están escritos en forma de variables de entorno.

* Alternativamente, si no deseas instalar Rails y Ruby, puedes agregar las siguientes líneas en el Dockerfile, a continuación del `ENV PROD_PASSWORD=xxxxx`:

``` sh
# Iniciamos Rails para test
ENV RAILS_ENV=test
# Creamos y luego migramos el modelo de datos en test
RUN ["rails", "db:create"]
RUN ["rails", "db:migrate"]
```
Esto provocara que al hacer el build de docker, cree la primera vez la base de datos de prueba. También podemos agregar luego de `ENV RAILS_ENV=production` algo similar, para construir la base de datos de producción.

``` sh
# Iniciamos Rails para test
ENV RAILS_ENV=test
# Creamos y luego migramos el modelo de datos en test
RUN ["rails", "db:create"]
RUN ["rails", "db:migrate"]
```
posteriormente deberás comentar las líneas agregadas, debido a que este paso solo se hace una vez. Recuerda también cambiar los usuarios y contraseñas, tanto para la base de datos test, como la de producción.

* Recuerda agregar la variable de entorno API_KEY, ya sea en el Dockerfile, descomentado la linea de `ENV API_KEY=xxxxxx`

## Archivos Importantes

``` sh
app/controller/tuten_service_controller.rb
test/controllers/tuten_service_controller_test.rb
config/routes.rb
Dockerfile

```
## End Point

La aplicacion funciona como un servicio API, el cual tiene los siguientes requerimientos, para ser consumida de forma local:
``` sh
PATH: `http://mydominio.cl:3000/hora-utc`
Method: POST
Body: {
    "time": "18:31:45",
    "zone": -3
}

```
* Ejemplo disponible hasta el dia 31/08/2020

``` sh
PATH: `http://xxxxxxx/hora-utc`
Method: POST
Body: {
    "time": "18:31:45",
    "zone": -3
}

```
