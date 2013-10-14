module Sptrans
  class BusStop < Hashie::Dash
    def initialize(args)
      args.each_pair do |k,v|
        self.k = v
      end
      self.address = Geocoder.address self.coord
    end

    def self.find(query)
      response = HTTParty.get("http://200.189.189.54/InternetServices/BuscaParadasSIM?termoBusca=#{q}")
      response["BuscaParadasSIMResult"].map do |stop|
        BusStop.new id: stop["CodigoParada"], name: stop["Nome"], coord: [stop["Latitude"], stop["Longitude"]]
      end
    end
  end
end
