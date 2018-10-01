class PagesController < ApplicationController

  def home
    @radios = Radio.all
  end
end
