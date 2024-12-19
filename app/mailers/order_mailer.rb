class OrderMailer < ApplicationMailer
    default from: 'no-reply@coffeeshop.com'

    def order_ready(order)
        @order = order
        mail(to: 'random_customer@example.com', subject: 'Your Order is Ready for Pickup!')
    end
end
