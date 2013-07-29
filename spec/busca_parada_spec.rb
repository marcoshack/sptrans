#-*- encoding: utf-8 -*-
require 'spec_helper'

describe Sptrans::BuscaParada do
  context "BuscaParada" do
    describe "should return all bus_stops (Parada), because no send query" do
      subject = Sptrans::BuscaParada
      response = subject.query "paulista"
      response.should_not nil
    end
  end
end
