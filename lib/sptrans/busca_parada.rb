module Sptrans::BuscaParada
  extend self
  def query(q)
    HTTParty.get "http://200.189.189.54/InternetServices/BuscaParadasSIM?termoBusca=#{q}"
  end
end
