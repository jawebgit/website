class User < ActiveRecord::Base
  has_one :shadow
  #id      int(11) 
  #uname   varchar(8)
  #group   varchar(9)
  #chicken   varchar(10)
  #created_at  datetime 
  #updated_at  datetime  
  
  def add_passwd(password)
    return false unless self.shadow.nil?
    passwd = User::Shadow.get_hash(self.uname, password)
    return self.create_shadow(uname: self.uname, passwd: passwd)
  end
  
end