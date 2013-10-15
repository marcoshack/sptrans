#-*- encoding: utf-8 -*-
require 'spec_helper'

describe Sptrans::BusStop do
  context "BuscaParada" do
    describe "should return all bus_stops (Parada), because no send query" do
      stops = BusStop.find("paulista")
      expect(stops).to_not be_nil
      expect(stop.first.id).to eq("4201929")
      expect(stop.first.name).to eq("")
    end
  end
end
