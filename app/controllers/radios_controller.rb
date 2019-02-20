class RadiosController < ApplicationController
  before_action :set_radio, only: [:show, :edit, :update, :get_img, :drafts]

  def show
  end

  def index
  end

  def new
    @radio = Radio.new
  end

  def create
    @radio = Radio.new(radio_params)
    if @radio.save
      redirect_to radio_path(@radio)
    else
      render "new"
    end
  end

  def get_img
    options = {}
    options[:searchType] = "image"
    radio_name = @radio.name + "ラジオ"

    results = GoogleCustomSearchApi.search(radio_name, options)
    begin
      img = results.items[rand(results.items.size)].link
    rescue => e
      img = ""
    end

    if @radio.update(img: img)
      redirect_to request.referrer
    else
      redirect_to request.referrer
    end
  end

  def drafts
    drafts = []
    User.open.each do |user|
      drafts += user.drafts.where(radio_id: params[:id], status: 1)
    end
    @drafts = drafts
  end

  def edit
  end

  def update
    if @radio.update(radio_params)
      redirect_to request.referrer, notice: 'success'
    else
      render "edit"
    end
  end

  def destroy
  end

  private

    def set_radio
      @radio = Radio.find(params[:id])
    end

    def radio_params
      params.require(:radio).permit(:name, :url, :img, :station_id, speaker_ids:[], speakers_attributes: [:name])
    end
end
