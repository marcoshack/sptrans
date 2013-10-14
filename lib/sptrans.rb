require "bundler"
require "sptrans/version"
require "hashie"
require "httparty"
require "geocoder"
#Bundler.require(:default)

Gem.find_files('sptrans/**/*.rb').each do |file|
  require file
end

module Sptrans

end
