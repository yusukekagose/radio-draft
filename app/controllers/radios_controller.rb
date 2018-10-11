class RadiosController < ApplicationController
  before_action :set_radio, only: [:show, :edit, :update]

  def show
  end

  def index
  end

  def new
    @radio = Radio.new
  end

  def create
    @radio = Radio.new(radio_params)
    puts radio_params
    if @radio.save
      redirect_to request.referrer, notice: 'success'
    else
      render "new"
    end
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
