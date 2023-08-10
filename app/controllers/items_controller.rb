class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

    def index
      @items = Item.order(created_at: :desc).limit(10)
    end
  
    def new
      @item_tag = Item.new
    end
  
    def create
      @item_tag = Item.new(item_params)
      if @item_tag.save
        #flash[:notice] = "アイテムが登録されました。"
        redirect_to items_path
      else
        render :new
      end
    end
  
    def show
      @item = Item.find(params[:id])
    end

    def edit
      @item = Item.find(params[:id]) #必要？
    end

    def update
      @item_tag = Item.find(params[:id])
        if @item_tag.update(item_params)
            redirect_to items_path
        else
            render :edit
        end
    end

    def destroy
      @item = Item.find(params[:id])
      @item.destroy
      redirect_to root_path
    end

    private
    def item_params
      params.require(:item).permit(:name, :condition_id, :rarity_id, :product, :release, :route, :get_date, :memo, :image, :tag)
    end
  end