class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

    def index
      @items = Item.order(created_at: :desc)#.limit(10)
    end
  
    def new
      @item_tag = ItemTag.new
    end
  
    def create
      @item_tag = ItemTag.new(item_tag_params)
  
      if @item_tag.valid?
        @item = Item.create(
          name: @item_tag.name,
          condition_id: @item_tag.condition_id,
          rarity_id: @item_tag.rarity_id,
          product: @item_tag.product,
          release: @item_tag.release,
          route: @item_tag.route,
          get_date: @item_tag.get_date,
          memo: @item_tag.memo
        )
        
        @item.image.attach(@item_tag.image)  # 画像をアタッチ
  
        tag_names = @item_tag.tag_name.split(',').map(&:strip)
        tag_names.each do |tag_name|
          tag = Tag.find_or_create_by(tag_name: tag_name)
          Tagging.create(item: @item, tag: tag)
        end
  
        redirect_to root_path
      else
        render :new
      end
    end
  
    def show
      @item = Item.find(params[:id])
    end

    def edit
      @item = ItemTag.find(params[:id])
    end

    def update
      @item_tag = ItemTag.find(params[:id])
        if @item_tag.update(item_tag_params)
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
    def item_tag_params
      params.require(:item_tag).permit(:name, 
                                      :condition_id, 
                                      :rarity_id, 
                                      :product, 
                                      :release, 
                                      :route, 
                                      :get_date, 
                                      :memo, 
                                      :image,
                                      :tag_name)
    end
  end