module Admin
  class CustomersController < ApplicationController
    before_filter :authenticate_user!   # This is devise, ensure we're logged in.
    layout 'admin' if -> { view_context.template_exists?('admin') }
    
    def index
      @datatable = ::Effective::Datatables::Customers.new() if defined?(EffectiveDatatables)
      @page_title = 'Customers'

      EffectiveOrders.authorized?(self, :manage, Effective::Customer)
    end

  end
end