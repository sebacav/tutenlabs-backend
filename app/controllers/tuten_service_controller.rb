class TutenServiceController < ApplicationController
    # Validamos parámetros antes de nuestro controlador principal
    before_action :validar_params, only: [:modificar_hora]

    # Metodo que formatea la hora y la devuelve
    def modificar_hora
        # Hacemos la resta de horas que se solicita
        @tiempo = @tiempo + @zone.hour
        # Formateamos para el standar que se solicita
        @tiempo = @tiempo.strftime("%H:%M:%S")
        # Devolvemos el json con un status 200
        render json: {response:{time: @tiempo, timezone: "utc"}}, status: :ok
    end

    private

    # Método que valida que los parámetros ingresados sean correctos
    def validar_params
        # Recibimos los parametros
        @tiempo = params[:time]
        @zone = params[:zone]
        begin
            # Validamos que sean correctos
            @tiempo = Time.parse(@tiempo)
            @zone = Integer(@zone)
        rescue => exception
            # Si algún parámetro no corresponde a su tipo
            # entonces devolveremos un bad_request
            render status: :bad_request
        end
    end

end
