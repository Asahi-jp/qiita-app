class HomeController < ApplicationController
  def index
    @page_num = params[:page]
    @items = Item.all.includes(:tags, :user).order(likes_count: :desc).page(@page_num).per(10)

    respond_to do |format|
      format.html
      format.js
    end
  end
end
