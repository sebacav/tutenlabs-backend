require 'test_helper'

class TutenServiceControllerTest < ActionDispatch::IntegrationTest
  test "Al consultar POST /hora-utc deberia arrojar un error 400, si envío la variable 'time' incorrecto" do
    post "/hora-utc", params: { time: 1648, zone: -3 }, as: :json
    assert_response :bad_request
  end
  test "Al consultar POST /hora-utc deberia arrojar un error 400, si envío la variable 'zone' incorrecto" do
    post "/hora-utc", params: { time: "18:31:45", zone: "hola" }, as: :json
    assert_response :bad_request
  end
  test "Al consultar POST /hora-utc deberia arrojar un error 400, si envío la variable 'time' y zone incorrecto" do
    post "/hora-utc", params: { time: "Hola", zone: "Nada" }, as: :json
    assert_response :bad_request
  end
  test "Al consultar POST /hora-utc deberia arrojar un status 200 y la hora devuelta deberia ser correcta" do
    post "/hora-utc", params: { time: "18:31:45", zone: -3 }, as: :json
    assert_equal JSON.parse(response.body)['response']['time'], "15:31:45" 
    assert_response :ok
  end
end
