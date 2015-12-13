class CartsController < ApplicationController
  before_action :authenticate_user!, only: [:checkout]
  
  def index
  end

  def checkout
  end
end
