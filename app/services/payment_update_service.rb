class PaymentUpdateService
  def initialize(service, line_item, index)
    @service = service
    @line_item = line_item
    @index = index
  end

  def call
    begin
      (payment = search) && update(payment) || create
    rescue ActiveRecord::RecordNotUnique
      retry
    end
  end

  protected

  def search
    Payment.where(service_id: @service.id, line_item_id: @line_item.id).first
  end

  def create
    Payment.create!(service_id: @service.id, line_item_id: @line_item.id,
      value: 1 << @index)
  end

  def update payment
    payment.with_lock do
      value = payment.reload.value | 1 << @index
      payment.update_attributes!(value: value)
    end
  end
end
