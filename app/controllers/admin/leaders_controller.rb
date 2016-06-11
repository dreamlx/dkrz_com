class Admin::LeadersController < Admin::BaseController
  def index
    @leaders = Leader.all
  end
end