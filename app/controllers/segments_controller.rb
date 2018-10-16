class SegmentsController < ApplicationController
  before_action :set_segment, only: [:toggle_status, :destroy]
  skip_before_action :verify_authenticity_token

  def index
    @segments = Radio.find(params[:id]).segments
  end

  def create
    # titles = segment_params[:name].gsub(/\s+/m, ' ').gsub(/^\s+|\s+$/m, '').strip.split(" ")
    @segment = Segment.new(segment_params)
    @segment.radio_id = params[:id]
    if @segment.save
      redirect_back(fallback_location: new_draft_path(params[:id]))
    else
      redirect_back(fallback_location: new_draft_path(params[:id]))
    end
  end

  def toggle_status
    if @segment.active?
      @segment.end!
    else
      @segment.active!
    end

    redirect_back(fallback_location: new_draft_path(@segment.radio_id))
  end

  def destroy
    if @segment.destroy
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private
    def segment_params
      params.require(:segment).permit(:name, :radio_id)
    end

    def set_segment
      @segment = Segment.find(params[:id])
    end
end
