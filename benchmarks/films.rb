require 'benchmark'
require 'net/http'
require 'uri'

iterations = 100

Benchmark.bm do |bm|
  u = 'http://lvh.me:3000/films'
  bm.report do
    iterations.times do
      Net::HTTP.get_response(URI.parse(u))
    end
  end
end