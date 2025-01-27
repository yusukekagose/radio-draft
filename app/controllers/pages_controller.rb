class PagesController < ApplicationController

  def home
    if params[:order].present?
      @radios = raido_by_order(params[:order])
    else
      @radios = Radio.all
    end
    @radios = @radios.search(params[:keyword]) if params[:keyword].present?
  end

  private

    def raido_by_order param_order
      case param_order
      when "all"
        Radio.all
      when "popular"
        Radio.order_by_favorites_count
      else
        Radio.order_by_drafts_count
      end
    end

end
