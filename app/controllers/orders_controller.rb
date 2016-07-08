class OrdersController < ApplicationController

  # GET /orders
  def index
    @orders = Order.all
    render json: @orders
  end

  # POST /orders
  def create
    @table = Table.find(params[:table_id])
    @order = @table.orders.build(order_params)

    if @order.save
      render json: @order, status: :created #, location: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  def add
    @order = Order.find params[:id]
    # order_item = @order.order_items.build(item_id: params[:item_id])

    order_item = OrderItem.where(order_id: @order.id, item_id: params[:item_id]).first.increment(:quantity) rescue
      @order.order_items.build(item_id: params[:item_id])

    if order_item.save
      render json: order_item, status: :created #201
    else
      render json: order_item.errors, status: :unprocessable_entity #422
    end
  end

  private
    # Only allow a trusted parameter "white list" through.
    def order_params
      params.require(:order).permit(:name, :email, :table_id)
    end
end
