class Admin::ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_required!

  def new
    @product = Product.new
    @photo = @product.photos.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to admin_products_path
    else
      render :new
    end
  end

  def index
    @products = Product.all
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Produc.find(params[:id])

    if @product.update(product_params)
      redirect_to admin_products_path
    else
      render :new
    end
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :quantity, :price, :photos_attributes => ["image"])
  end
end