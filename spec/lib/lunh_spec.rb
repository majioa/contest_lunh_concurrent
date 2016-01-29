require 'rails_helper'

RSpec.describe Aus::Lunh, type: :lib do
  describe "Linh algo" do
    context "is calculated well" do
      let(:cardno) { '0465827879483596' }

      it { expect(subject.is_number_valid?(cardno)).to be_truthy }
      it { expect(subject.encode(cardno)).to be_eql('04658278794835966') }
    end
  end
end
