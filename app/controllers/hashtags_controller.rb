class HashtagsController < ApplicationController
  before_action :require_user

  def show
    @statuses = Status.where("body LIKE ?", "%##{params[:id]}%")
  end
end