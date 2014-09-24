class UsersController < AuthenticationController
  before_action :brochicken_permissions
  
  def create
    @user = User.new(params)
    if @user.valid?
      @user.save
      check_redirect(params, users_path)
    else
      render "new"
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def index
    @users = User.list
  end
  
  def new
    @user = User.new
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params)
      check_redirect(params, users_path)
    else
      render 'edit'
    end
  end
  
  #######Adding a pledge class ###################
  
  def add_pledges
  end
  
  def create_pledges
    if params.include? :user
      User.create_pledges(params.require(:user))
      flash[:success] = "Users created"
      redirect_to users_path
    else
      flash[:error] = "No users to add"
      render "add_pledges"
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
  
  def query
    @results = User::MitLdap.query(query_params(params))
    render partial: 'query', object: @results
  end
  
 private
 
  def check_redirect(params, redirect_path)
    if params[:user][:brother_id] == "new"
      redirect_to new_brother_url + "?user_id=" + @user.id.to_s
    else
      redirect_to redirect_path
    end
  end
 
  def filter_params(params)
    return params.permit("group", "year", "house", "admin")
  end
  
  def query_params(params)
    return params.require(:query).permit(:uname, :first, :last)
  end
  
end