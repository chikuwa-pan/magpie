class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

    def index
      @items = Item.order(created_at: :desc).page(params[:page]).per(12) # アイテム一覧の取得
      @tag_list=Tag.all
    end
  
    def new
      @item_tag = ItemTag.new
    end
  
    def create
      Rails.logger.info("create action started")
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
      @item = Item.find(params[:id])
      @item_tag = ItemTag.new(
        name: @item.name,
        condition_id: @item.condition_id,
        rarity_id: @item.rarity_id,
        product: @item.product,
        release: @item.release,
        route: @item.route,
        get_date: @item.get_date,
        memo: @item.memo,
        tag_name: @item.tags.pluck(:tag_name).join(', ') #タグの間に, を入れて表示
      )
    end

    def update
      @item = Item.find(params[:id])
      @item_tag = ItemTag.new(item_tag_params)

        if @item_tag.valid?
          @item.tags.destroy_all
          if @item_tag.tag_name.present?
            tag_names = @item_tag.tag_name.split(',').map(&:strip).reject(&:blank?) #sprit(',')は,で区切って配列に変換する rejectは配列意外だとエラーになるので
                                                          #空でない（非空文字列である）タグ名の配列を取得
                                                          #blank? メソッドはオブジェクトが空かどうかを判定するメソッドで、空文字列や nil の場合に true を返します。
                                                          #reject メソッドは、指定された条件に一致する要素を取り除いた新しい配列を返します。
            tag_names.each do |tag_name| #配列の各要素に対して繰り返し処理
              tag = Tag.find_or_create_by(tag_name: tag_name) #Tag モデルから、与えられたタグ名 tag_name に対応するタグをデータベースから検索します。見つかればそのタグを、見つからなければ新しいタグを作成して返します。
              Tagging.create(item: @item, tag: tag) #Tagging モデルに新しいレコードを作成します。item カラムには @item インスタンスを、tag カラムには tag インスタンスを指定します。これにより、アイテムとタグの関連付けが行われます。
            end
          end

            if @item.update(
              name: @item_tag.name,
              condition_id: @item_tag.condition_id,
              rarity_id: @item_tag.rarity_id,
              product: @item_tag.product,
              release: @item_tag.release,
              route: @item_tag.route,
              get_date: @item_tag.get_date,
              memo: @item_tag.memo
            )
            redirect_to items_path
          else
            render :edit
          end
        else
          render :edit
        end
    end

    def destroy
      @item = Item.find(params[:id])
      @item.destroy
      redirect_to root_path
    end

    def search
      if params[:search].present?
        @search_results = Item.search(params[:search]).order(created_at: :desc)
        logger.debug "Search Results in Search Action: #{@search_results}"
      end
    end

    def search_tag
      # 検索結果画面でもタグ一覧表示
      @tag_list = Tag.all
      # 検索されたタグを受け取る
      @tag = Tag.find(params[:tag_id])
      # 検索されたタグに紐づく投稿を表示
      @items = @tag.items.order(created_at: :desc)
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