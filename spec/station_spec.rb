require 'station'

describe Station do

  subject(:station) { described_class.new('Angel', 'zone: 1') }

  it 'should have a name on creation' do
    expect(subject.name).to eq('Angel')
  end

  it 'should have a zone on creation' do
    expect(subject.zone).to eq('zone: 1')
  end

end
