class Admin::LeadersController < Admin::BaseController
  def index
    @leaders = Leader.page params[:page]
  end
end