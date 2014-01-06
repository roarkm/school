require "user_sanitizer"

class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :admin?, :current_school

  def admin?
    user_signed_in? && current_user.admin
  end

  def admin_only
    redirect_to root_path unless admin?
  end

  def current_school
    unless @current_school
      if params[:school]
        @current_school = School.find_by_slug(params[:school])
      elsif session[:school]
        @current_school = School.find_by_slug(session[:school])
      elsif current_user
        @current_school = current_user.school
      end
    end

    unless @current_school
      begin
        loc = request.location
        @current_school = Venue.near([loc.latitude, loc.longitude], 5000)
                               .first
                               .school
      rescue StandardError
      end
    end

    unless @current_school
      @current_school = Venue.order("created_at").first.school
    end

    session[:school] = @current_school.slug if @current_school
    @current_school
  end

  def devise_parameter_sanitizer
    if resource_class == User
      User::ParameterSanitizer.new(User, :user, params)
    else
      super
    end
  end
end
