class AnimesController < ApplicationController
  def index
    if params[:query].present?
      @animes = Anime.where("title LIKE ? COLLATE NOCASE", "%#{params[:query]}%").order("score DESC").page(params[:page]).per(24)
    else
      @animes = Anime.order("score DESC").page(params[:page]).per(24) # Show 24 animes per page
    end
  end

  def show
    @animes = Anime.find(params[:id])
  end
end
