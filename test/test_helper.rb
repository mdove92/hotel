require "simplecov"
require "minitest"
require "minitest/autorun"
require "minitest/reporters"
require "rake"
require "date"
SimpleCov.start do
  add_filter "test/"
end

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative "../lib/Booker"

require_relative "../lib/date_range"
require_relative "../lib/reservations"
