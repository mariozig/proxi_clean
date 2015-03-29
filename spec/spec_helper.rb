$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'proxi_clean'
require 'vcr'

RSpec.configure do |c|
  # Stuff?
end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
end
