class PaymentUpdateService
  def initialize(service, line_item)
    @service = service
    @line_item = line_item
  end

  def call
    payment = Payment.first_or_initialize(service_id: @service.id,
                                          line_item_id: @line_item.id)
    payment.save!
  end
end
