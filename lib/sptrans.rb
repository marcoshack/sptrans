require "yaml"
require "httparty"
require "sptrans/version"

Gem.find_files('sptrans/**/*.rb').each do |file|
  require file
end

module Sptrans

end
