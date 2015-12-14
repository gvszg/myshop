class CartItemsController < ApplicationController
  def destroy
    @cart = current_cart
    @item = @cart.cart_items.find(params[:id])
    @product = @item.product
    @item.destroy
    flash[:warning] = "Successfully delete #{@product.title} from cart!"
    redirect_to :back
  end
end
