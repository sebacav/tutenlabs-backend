Rails.application.routes.draw do
  # Ruta del metodo que nos devuelve la hora basado en el tiempo y zona
  post     '/hora-utc',             to: 'tuten_service#modificar_hora'
end
