class UsersController < ApplicationController
  def show
    @drafts = current_user.drafts
  end
end
