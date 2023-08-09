class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

    def index
      @items = Item.includes(:user).order(created_at: :desc).limit(10)
    end
  
    def new
      @item = Item.new
    end
  
    def create
      @item = Item.new(item_params)
      @item.user_id = current_user
      if @item.save
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
      @item = Item.find(params[:id])
        if @item.user == current_user
            @item.update(item_params)
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
      params.require(:item).permit(:name, :condition_id, :rarity_id, :product, :release, :route, :get_date, :memo, :image).merge(user_id: current_user.id)
    end
  end
  