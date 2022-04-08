class HomeController < ApplicationController
  def index
    @q = Item.ransack(params[:q])
    @page_num = params[:page]
    @type = params[:type]
    today = Date.today.beginning_of_day..Date.today.end_of_day
    three_days = Date.today.ago(3.days)..Date.today.end_of_day

    @today_items = @q.result.where(created_at: today).includes(:tags, :user).order(likes_count: :desc).page(@page_num).per(10)
    @three_days_items = @q.result.where(created_at: three_days).includes(:tags, :user).order(likes_count: :desc).page(@page_num).per(10)
    @all_items = @q.result.order(likes_count: :desc).includes(:tags, :user).page(@page_num).per(10)

    respond_to do |format|
      format.html
      format.js
    end
  end
end
