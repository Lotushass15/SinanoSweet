class Admin::GenresController < ApplicationController
    before_action :authenticate_admin!
    layout 'admin'
    
    def index
      @genres = Genre.all
      @genre = Genre.new
    end
    
    def create
      @genre = Genre.new(genre_params)
      if @genre.save
        redirect_to admin_genres_path
      else
        @genres = Genre.all
        render action: :index
      end
    end
    
    def edit
      @genre = Genre.find(params[:id])
    end
    
    def update
      @genre = Genre.find(params[:id])
      if @genre.update(genre_params)
        redirect_to admin_genres_path
      else
        @genre = Genre.find(params[:id])
        render action: :edit
      end
    end
    
    private
    def genre_params
      params.require(:genre).permit(:name)
    end
end
