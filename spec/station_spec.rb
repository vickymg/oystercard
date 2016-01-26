require 'station'

describe Station do

  subject(:station) {described_class.new(:name, :zone)}

  describe "#initialize" do

    it "instantiates with name and zone on creation" do
      expect(station).to have_attributes(:name => :name, :zone => :zone)
    end

  end



  it {is_expected.to respond_to(:name)}

  it {is_expected.to respond_to(:zone)}

end
