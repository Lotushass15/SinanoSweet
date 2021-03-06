class Admin::ItemsController < ApplicationController
    before_action :authenticate_admin!
    layout 'admin'
    
    def index
      if params[:search].present?
        @searches = Item.page(params[:page]).per(10).search(params[:search])
      end
        @items = Item.page(params[:page]).per(10)
    end
    
    def show
      @item = Item.find(params[:id])
    end
    
    def new
      @item = Item.new
    end
    
    def create
      @item = Item.new(item_params)
      if @item.save
        redirect_to admin_item_path(@item)
      else
        render action: :new
      end
    end
    
    def edit
      @item = Item.find(params[:id])
    end
    
    def update
      @item = Item.find(params[:id])
      if @item.update(item_params)
        redirect_to admin_items_path
      else
        render action: :edit
      end
    end
    
    private
    def item_params
      params.require(:item).permit(:image, :name, :introduction, :genre_id, :price, :is_active)
    end
    
end
