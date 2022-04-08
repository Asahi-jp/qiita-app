class HomeController < ApplicationController
  def index
    @q = Item.ransack(params[:q])
    @page_num = params[:page]
    @items = @q.result.order(likes_count: :desc).includes(:tags, :user).page(@page_num).per(10)

    
    
    
    respond_to do |format|
      format.html
      format.js
    end
  end
end
