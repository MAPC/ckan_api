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

end