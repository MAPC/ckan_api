module CKAN
  class API

    # TODO: API versioning
    # Should have separate modules to handle different versions
    @api_url = "http://demo.ckan.org/api/3/"
    def self.api_url=(api_url)
      @api_url = api_url
    end
    def self.api_url
      @api_url
    end

    # TODO: Alias api_url => base_url
  end
end

# TODO: Consistent quotes
require 'addressable/uri'
require 'open-uri'
require "net/http"
require "uri"
require 'json'

# TODO: Require globbed files
require_relative 'ckan/model'
require_relative 'ckan/group'
require_relative 'ckan/package'
require_relative 'ckan/resource'
require_relative 'ckan/version'
require_relative 'ckan/datastore'
