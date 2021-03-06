module CKAN
  class Package < Model

    # Package List
    self.site =  "action/package_list"

    # Package Search
    self.search = "action/package_search"

    # Package Show
    self.show = "action/package_show"

    attr_reader :id
    lazy_reader :name, :license_title, :title, :url, :description, :version, :author, :author_email,
      :maintainer, :maintainer_email, :license_id, :notes, :relationships_as_object, :private,
      :maintainer_email, :revision_timestamp, :metadata_created, :metadata_modified, :author,
      :author_email, :state, :version, :creator_user_id, :type, :resources, :num_resources,
      :tags, :tracking_summary, :groups, :license_id, :relationships_as_subject, :num_tags,
      :organization, :name, :isopen, :url, :notes, :owner_org, :extras, :title, :revision_id

    def initialize(id)
      @id = id
    end

    def self.find(options={})
      if options.empty?
        @all_packages ||= read_remote_json_data(self.site)['result'].map{ |id| Package.new(id) }
      else

        # Remove :tags and make :q
        %w( id tags ).each do |opt|
          opt = opt.to_sym
          if options[opt]
            options[:q] = "#{opt}:" << Array( options.delete(opt) ).join('+')
          end
        end
        
        url = Addressable::URI.parse(self.search)
        url.query_values = options

        result = read_remote_json_data(self.unencode(url))
        Array( result["result"]["results"] ).map{ |data| Package.new(data['id']) }

        # if result["count"] != result["results"].size
        #   query += "&offset=#{result["results"].size}&limit=#{result["count"] + result["results"].size}"
        #   result["results"] += read_remote_json_data(self.search + query)["results"]
        # end
      end
    end

    def resources
      read_lazy_data
      @mapped_resources ||= @resources.map { |data| Resource.new(data) }
    end

    def to_s
      "#<CKAN::Package:#{@id}>"
    end

    private
      def self.unencode(url)
        Addressable::URI.unencode(url)
      end
  end
end
