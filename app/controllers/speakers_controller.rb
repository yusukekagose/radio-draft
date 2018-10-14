class SpeakersController < ApplicationController
  before_action :set_radio, only: [:index, :create, :destroy_radio_speakers]
  skip_before_action :verify_authenticity_token

  def index
    @speakers = @radio.speakers
  end

  def update
  end

  def create
    @radio.speakers.build
    speaker = Speaker.find_or_create_by(speaker_params)
    @radio.speakers << speaker
    if @radio.save
      redirect_back(fallback_location: edit_radio_path(params[:id]))
    else
      redirect_back(fallback_location: edit_radio_path(params[:id]))
    end
  end

  def destroy_radio_speakers
    speaker = @radio.speakers.find(params[:speaker_id])

    if speaker
      if @radio.speakers.delete(speaker)
        redirect_back(fallback_location: edit_radio_path(params[:id]))
      else
        redirect_back(fallback_location: edit_radio_path(params[:id]))
      end
    end
  end

  private

  def set_radio
    @radio = Radio.find(params[:id])
  end

  def speaker_params
    params.require(:speaker).permit(:name)
  end

end
