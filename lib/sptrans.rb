require "bundler"
require "sptrans/version"
Bundler.require(:default)

Gem.find_files('sptrans/**/*.rb').each do |file|
  require file
end

module Sptrans

end
