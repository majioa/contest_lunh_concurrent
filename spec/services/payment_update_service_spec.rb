require 'rails_helper'

RSpec.describe PaymentUpdateService, type: :service do
  describe '#call' do
    let!(:upserv) { PaymentUpdateService.new(service, line_item) }
    let!(:service) { FactoryGirl.create :service }
    let!(:line_item) { FactoryGirl.create :line_item }
    let!(:c) { Payment }
    let!(:threads) do
       Thread.abort_on_exception = true
       Array.new(5) { Thread.new { upserv.call } }
    end

    let(:payments) do
       while(threads.any? { |t| t.status == 'sleep' }) { sleep 0.1 }

       Payment.where(service_id: service.id, line_item_id: line_item.id)
    end

    it 'performs payment' do
      expect(payments.count).to be_eql(1)
    end
  end
end
