module CKAN
  class Model
    protected

    def read_lazy_data
      unless @lazy_data_read
        show_response = self.class.read_remote_json_data(self.class.show + "?id=" + self.id)
        show_response["result"].each do |name,value|
          self.instance_variable_set("@"+name,value)
        end
        @lazy_data_read = true
      end
    end

    def self.site=(address)
      @site = address
    end

    def self.base
      CKAN::API.api_url
    end

    def self.site
      base + @site
    end

    def self.search=(address)
      @search = address
    end

    def self.search
      base + @search
    end

    def self.show=(address)
      @show = address
    end

    def self.show
      base + @show
    end

    # TODO: change method name. It's almost as long
    #       as the method itself. Maybe #parse_json,
    #       #read_json, or even #parse or #read.
    def self.read_remote_json_data(address)
      # puts address
      JSON.parse(open(address).read)
    end

    def self.lazy_reader(*names)
      names.each do |name|
        define_method(name) do
          read_lazy_data
          instance_variable_get("@" + name.to_s)
        end
      end
    end
  end
end
