class PagesController < ApplicationController

  def home
    if params[:order].present?
      @radios = Radio.order_by_drafts_count
    else
      @radios = Radio.all
    end
    if params[:keyword].present?
      @radios = @radios.search(params[:keyword])
    end
  end

end
