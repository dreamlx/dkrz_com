module ApplicationHelper
  def admin_log_in(admin)
    session[:admin_id] = admin.id
    @current_admin = admin
  end

  def current_admin
    @current_admin || Admin.find_by(id: session[:admin_id])
  end

  def admin_logged_in?
    !current_admin.nil?
  end

  def admin_logout
    session.delete(:admin_id)
    @current_admin = nil
  end
end
