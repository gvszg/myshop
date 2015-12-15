class CartItemsController < ApplicationController
  def destroy
    @cart = current_cart
    @item = @cart.cart_items.find(params[:id])
    @product = @item.product
    @item.destroy
    flash[:warning] = "Successfully delete #{@product.title} from cart!"
    redirect_to :back
  end

  def update
    @cart = current_cart
    @item = @cart.cart_items.find(params[:id])

    if @item.product.quantity >= (params[:cart_item][:quantity]).to_i
      @item.update(item_params)
      flash[:notice] = "成功變更數量"
    else
      flash[:warning] = "數量不足以加入購物車"
    end

    redirect_to carts_path
  end

  private

  def item_params
    params.require(:cart_item).permit(:quantity)
  end
end
