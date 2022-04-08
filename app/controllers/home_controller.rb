class HomeController < ApplicationController
  def index
    @items = Item.all.includes(:tags, :user).order(likes_count: :desc).page(params[:page]).per(10)
  end
end
