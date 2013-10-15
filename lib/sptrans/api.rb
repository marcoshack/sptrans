module Sptrans::Api
  include HTTParty
  extend self

  SPTRANS_API_BASE_URL = "http://olhovivo.sptrans.com.br"
  SPTRANS_API_VERSION = "/v0"

  def get_credentials
    cookies = HTTParty.get('http://olhovivo.sptrans.com.br/').headers["set-cookie"]
    return cookies.split("apiCredentials-v0=").last
  end

  def line(name = "")
    uri = "/Linha/Buscar?termosBusca=#{name}"
    get_on_api uri
  end

  def bus_stop(name="")
    uri = "/Parada/Buscar?termosBusca=#{name}"
    get_on_api uri
  end

  # TODO: Documentar
  # Forecast bus arrival on this #bus_stop.
  # In file "forecast_return_sample.json" somple to > Sptrans::Api.forecast("260015039")
  def forecasts(bus_stop="")
    uri = "/Previsao/Parada?codigoParada=#{bus_stop}"
    get_on_api uri
  end

  protected
  def get_on_api(uri = "/")
    cookies( {"apiCredentials-v0"=> get_credentials} )
    get SPTRANS_API_BASE_URL+SPTRANS_API_VERSION+uri
  end
end
