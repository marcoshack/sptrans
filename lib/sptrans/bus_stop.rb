module Sptrans
  class BusStop < OpenStruct

    def address
      Geocoder.address self.coord
    end

    def self.find(name)
      Sptrans::Api.bus_stop(name).map do |bus_stop|
        BusStop.new(
          id:       bus_stop["CodigoParada"],
          name:     bus_stop["Nome"],
          coord:    "#{bus_stop["Latitude"]}, #{bus_stop["Longitude"]}"
        )
      end
    end
  end
end
