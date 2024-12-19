class ProcessOrderJob < ApplicationJob
  queue_as :default

  def perform(order_id)
    order = Order.find(order_id)

    # Update order status to "ready for pickup" and set completion time
    order.update!(status: 'completed', completed_at: Time.current)

    # Send notification to the customer (this can be an email or a push notification)
    OrderMailer.order_ready(order).deliver_now
  end
end
