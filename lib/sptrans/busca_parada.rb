module Sptrans::BuscaParada
  extend self
  def find(q)
      response = HTTParty.get("http://200.189.189.54/InternetServices/BuscaParadasSIM?termoBusca=#{q}")
      binding.pry
  end
end
