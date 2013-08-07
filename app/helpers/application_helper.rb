module ApplicationHelper
  
  def render_errors(user)
    return nil if user.nil?
    provide(@target = user)
    return (render "shared/error_messages").html_safe
  end

  def get_name(username)
    username = 'wallace4' if !Rails.env.production?  
    tmp = BrothersPersonal.find_by( uname: username)
    return tmp.full_name if tmp
    return username
  end
  
  def gen_title(page_title)
    site_title="DKE Server"
    if (page_title!="")
      return "#{site_title} | #{page_title}" 
    else
      return site_title
    end
  end
  
end
