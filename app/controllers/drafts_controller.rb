class DraftsController < ApplicationController
  before_action :set_draft, only: [:edit, :update, :destroy, :toggle_status]
  before_action :authenticate_user!, only: [:index, :new, :create, :edit, :update, :destroy]
  before_action :is_author, only: [:edit, :update, :destroy]

  def index
    @drafts = current_user.drafts.order(created_at: :desc)
  end

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

  def edit
    @radio = @draft.radio
  end

  def update
    if @draft.update(draft_params)
      redirect_to user_path(current_user)
    else
      render "edit"
    end
  end

  def destroy
    @draft.destroy
  end

  def toggle_status
    if @draft.draft?
      @draft.sent!
    else
      @draft.draft!
    end
  end

  def radio_draft
    @drafts = Radio.find(params[:id]).drafts
  end

  private
    def set_draft
      @draft = Draft.find(params[:id])
    end

    def draft_params
      params.require(:draft).permit(:title, :content, :segment_id).merge(user_id: current_user.id)
    end

    def is_author
      @draft = Draft.find(params[:id])
      unless @draft.user_id = current_user.id
        redirect_to root_path
      end
    end
end
