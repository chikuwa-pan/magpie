class ItemsController < ApplicationController
  def index
    @items = Item.order(release: :desc).limit(10)
  end

  def new
    @items = Item.all
  end

  def create

  end
end