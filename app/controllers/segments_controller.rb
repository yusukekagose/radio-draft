class SegmentsController < ApplicationController
  def create
    # titles = segment_params[:name].gsub(/\s+/m, ' ').gsub(/^\s+|\s+$/m, '').strip.split(" ")
    @segment = Segment.new(segment_params)
    @segment.radio_id = params[:id]
    if @segment.save
      redirect_to request.referrer, notice: 'success'
    else
      redirect_to request.referrer
    end
  end

  private
    def segment_params
      params.require(:segment).permit(:name, :radio_id)
    end
end
