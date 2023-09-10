class UsersController <ApplicationController 
  def new 
    @user = User.new()
  end 

  def show
    if current_user
      @user = User.find(params[:id])
    else
      flash[:error] = "You must be registered and logged in to access user dashboard."
      redirect_to root_path
    end
  end 

  def create 
    user = user_params
    user[:email] = user[:email].downcase
    new_user = User.create(user_params)
    if new_user.save
      session[:user_id] = new_user.id
      redirect_to user_path(new_user)
    else  
      flash[:error] = new_user.errors.full_messages.to_sentence
      redirect_to register_path
    end 
  end
  
  private 

  def user_params 
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end 
end 