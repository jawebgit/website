class UsersController < AuthenticationController
  
  def add_pledges
    
  end
  
  def index
    @users = User.list
  end
  
  def new
    @user = User.new
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(params)
    if @user.valid?
      @user.save
      redirect_to users_path
    else
      render "new"
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params)
      redirect_to users_path
    else
      render 'edit'
    end
  end
  
  ##############Partials###################
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy(params[:all]=='true')
    render text: "User deleted"
  end
  
  def filter
    @users = User.list(filter_params(params))
    render partial: 'filter', object: @users
  end
  
  def kerberos
    begin
      result = !User::MitLdap.find(params[:uname]).nil?
    rescue
      result = false
    end
    render text: result
  end
  
 private
 
  def filter_params(params)
    return params.permit("group", "year", "house", "admin")
  end
  
end