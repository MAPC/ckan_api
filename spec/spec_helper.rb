require File.expand_path(File.dirname(__FILE__) + '/../lib/ckan')
require 'vcr'
require 'webmock'
include WebMock

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/requests'
  config.hook_into :webmock
  config.configure_rspec_metadata! # Auto-name requests based on test name
  config.default_cassette_options = { 
    record: :new_episodes,
    re_record_interval: 604800 # 1.week.to_i (without Rails)
  }
end

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
end

include CKAN
