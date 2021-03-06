class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_navigation_for_devise_controllers
  before_filter :get_broadcasts
  
  helper_method :in_demo?, :guest_view?
  
  layout :layout_by_resource
  
  protected

  def no_background!
    @no_background = true
  end

  def navigation(identifier)
    @navigation_id = identifier
  end
  
  def title(title)
    @title = title
  end

  def set_navigation_for_devise_controllers
    if controller_name == "registrations" && action_name == "edit"
      navigation :account
    end
  end
  
  def get_broadcasts
    if user_signed_in?
      @broadcast = (Broadcast.all - Broadcast.joins(:users).where("users.id" => current_user.id)).first
    end
  end
  
  def in_demo?
    user_signed_in? && current_user.email =~ /@demoaccount.com/
  end
  
  def guest_view?
    request.path =~ /\/guest\//i
  end
  
  def layout_by_resource
    if devise_controller? && resource_name == :admin
      "magic"
    else
      "application"
    end
  end
end
