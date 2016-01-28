require_relative "../lib/journey_log.rb"

describe JourneyLog do
  let(:subject) {described_class.new}

  it {is_expected.to respond_to(:journey_history)}

end
