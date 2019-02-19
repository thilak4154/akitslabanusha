class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def flash_message(type, text)
    flash[type] ||= []
    flash[type] << text
  end

  def render_flash
    rendered = []
    flash.each do |type, messages|
      messages.each do |m|
        rendered << render(:partial => 'partials/flash', :locals => {:type => type, :message => m}) unless m.blank?
      end
    end
    rendered.join('<br/>')
  end

  def user_logged_in?
    unless session[:email]
      flash[:notice] = "Please log in."
      redirect_to(:controller => 'login', :action => 'new')
      return false # halts the before_filter
    else
      return true
    end
  end
end
