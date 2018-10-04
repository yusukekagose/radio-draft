class SegmentsController < ApplicationController

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

  private
    def segment_params
      params.require(:segment).permit(:name, :radio_id)
    end
end
