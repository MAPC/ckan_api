require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CKAN::Package, vcr: { cassette_name: "colournames package" } do
  before(:each) do
    @package = CKAN::Package.new({})
  end
  
  describe "initialization" do
    subject { @package }
    # its(:id) { should == "colournames" }
  end
  
  describe "#find" do
    context "without search options", vcr: { cassette_name: "find all packages" } do
      let(:all_packages) { CKAN::Package.find }

      it "should return an array of all packages" do
        all_packages.should be_kind_of Array
        all_packages.count.should be_between(1000,10000)
      end

      it "should consist of Package objects" do
        all_packages.first.should be_kind_of Package
      end
    end
    
    context "with tags", vcr: { cassette_name: "find packages tagged government and weather" } do
      let(:tagged_packages) { CKAN::Package.find(tags: ["government", "weather"]) }

      it "should return an array of tagged packages" do
        tagged_packages.should be_kind_of Array
        tagged_packages.count.should be_between(1,2)
      end

      it "should consist of Package objects" do
        tagged_packages.first.should be_kind_of Package
      end
    end

    context "with limits", vcr: { cassette_name: "find packages with rows" } do
      let(:limited_packages) { CKAN::Package.find(rows: 5) }
      it "should return 5 packages" do
        limited_packages.should be_kind_of Array
        limited_packages.count.should eq(5)
        limited_packages.first.should be_kind_of Package
      end
    end

  end
  
  describe "#resources", vcr: { cassette_name: "resources" } do
    let(:package) { CKAN::Package.find(id: "3dbae792-3443-4171-bb10-afb8759364c3").first }
    it "should return details about an individual package" do
      resource = package.resources.first
      resource.url.should eq("http://opendata.smhi.se")
      resource.description.should eq("SMHI open data services")
      resource.last_modified.should    be_nil
      resource.datastore_active.should be_false
    end
  end
  
  describe "#to_s" do
    let(:package) { CKAN::Package.find(id: "3dbae792-3443-4171-bb10-afb8759364c3").first }
    it "should return the package ID in a string" do
      package.to_s.should eq "#<CKAN::Package:3dbae792-3443-4171-bb10-afb8759364c3>"
    end
  end

  describe "attributes", vcr: { record: :new_episodes } do
    let(:package) { CKAN::Package.find(id: "9ac6aee4-3882-41a1-ae4e-eef9ccb21745").first }
    let(:attributes) {
      %w(
          id license_title maintainer relationships_as_object private 
          maintainer_email revision_timestamp metadata_created 
          metadata_modified author author_email state version creator_user_id 
          type resources num_resources tags tracking_summary groups license_id
          relationships_as_subject num_tags organization name isopen url notes
          owner_org extras title revision_id
      )
    }
    it "should be able to access every instance variable" do
      attributes.each {|attrib| 
        expect{ package.send(attrib) }.to_not raise_error
      }
    end
  end


end