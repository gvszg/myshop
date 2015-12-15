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
    @item.update(item_params)
    redirect_to carts_path
  end

  private

  def item_params
    params.require(:cart_item).permit(:quantity)
  end
end
