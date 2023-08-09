class ItemsController < ApplicationController
  def index

  end

  def new
    @items = Item.all
  end

  def create

  end
end