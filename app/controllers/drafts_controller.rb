class DraftsController < ApplicationController
  def new
    @radio_id = params[:id]
    @draft = Draft.new
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
      params.require(:draft).permit(:title, :content).merge(user_id: current_user.id)
    end
end
