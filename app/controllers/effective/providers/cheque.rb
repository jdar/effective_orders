module Effective
  module Providers
    module Cheque
      extend ActiveSupport::Concern

      def pay_by_cheque
        @order = Order.find(params[:id])
        EffectiveOrders.authorized?(self, :update, @order)

        if @order.update_attributes(purchase_state: EffectiveOrders::PENDING)
          current_cart.try(:destroy)
          flash[:success] = 'Created pending order successfully!'
        else
          flash[:danger] = 'Unable to create your pending order. Please check your order details and try again.'
        end

        redirect_to effective_orders.order_path(@order)
      end
    end
  end
end
