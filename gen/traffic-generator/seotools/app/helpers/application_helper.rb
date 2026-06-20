module ApplicationHelper
  def current_user
    return session[:profile]['name'] unless session[:profile].nil?
  end

  def current_user_image
    return session[:profile]['picture'] unless session[:profile].nil?
  end

  def current_user_profile_url
    return session[:profile]['link'] unless session[:profile].nil?
  end
end
