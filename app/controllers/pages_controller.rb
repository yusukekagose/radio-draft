class PagesController < ApplicationController

  def home
    if params[:keyword].present?
      @radios = Radio.search(params[:keyword])
    else
      @radios = Radio.all
    end
  end
end
