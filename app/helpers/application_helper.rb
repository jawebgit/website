module ApplicationHelper

  def get_name(username)
    username = 'wallace4' if !Rails.env.production?  
    tmp = BrothersPersonal.find_by( uname: username)
    return "#{tmp.first_name} #{tmp.last_name}" if tmp
    return username
  end
  
  def in_group(group_name)
    return true if !Rails.env.production?
    groups=Array([])
    File.open('/etc/apache2/dke_users.groups').each_line do |line|
      if (line[0]!="#" && line[0]!="\n")
        ofset = line.index(':')
        user_list = line[ofset..-1]
        if user_list.index(ENV['REMOTE_USER'])
          groups << line[0..ofset-1]
        end
      end
    end
    return true if groups.include? group_name
    return false
  end
  
  

end
