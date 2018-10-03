class DraftsController < ApplicationController
  def new
    @radio = Radio.find(params[:id])
    @draft = Draft.new
    @segment = Segment.new
  end

  def create
    @draft = Draft.new(draft_params)
    @draft.radio_id = params[:id]
    if @draft.save
      redirect_to request.referrer, notice: 'success'
    else
      render "new"
    end
  end

  private
    def draft_params
      params.require(:draft).permit(:title, :content, :segment_id).merge(user_id: current_user.id)
    end
end
