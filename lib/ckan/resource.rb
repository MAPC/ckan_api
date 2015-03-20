require 'time'

module CKAN
  class Resource

    def initialize(data)
      @data = OpenStruct.new(data)
    end

    def method_missing(method_name, *args, &block)
      @data.send(method_name)
    end

    def respond_to?(method_name)
      @data.respond_to? method_name
    end

    def to_s
      "#<CKAN::Resource:#{id}>"
    end

  end
end
