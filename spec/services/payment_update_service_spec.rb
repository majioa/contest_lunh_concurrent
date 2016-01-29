require 'rails_helper'

RSpec.describe PaymentUpdateService, type: :service do
  describe 'Payment Update service' do
    let!(:service) { FactoryGirl.create :service }
    let!(:line_item) { FactoryGirl.create :line_item }
    let(:payments) do
       Payment.where(service_id: service.id, line_item_id: line_item.id)
    end

    context "updates locked record" do
      UPDATE_COUNT = 5
      before do
        (0...UPDATE_COUNT).each do |i|
           fork_with_new_connection do
             PaymentUpdateService.new(service, line_item, i).call
           end
        end
        Process.waitall
      end

      it { expect(payments.count).to be_eql(1) }
      it { expect(payments.first.value).to be_eql((1 << UPDATE_COUNT) - 1) }
    end

    context "encounters unique record" do
      before do
        Payment.create(service_id: service.id, line_item_id: line_item.id)
        PaymentUpdateService.new(service, line_item, 0).call
      end

      it { expect(payments.count).to be_eql(1) }
    end
  end
end
