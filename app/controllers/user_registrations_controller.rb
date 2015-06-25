class UserRegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    super
  end

  def edit
    super
  end

  def cancel
    super
  end

  def destroy
    super
  end
  def update
    @user = User.find(current_user.id)
    email_changed = @user.email != params[:user][:email]
    if !Identity.find_by_user_id(@user.id).nil?
      is_facebook_account = !Identity.find_by_user_id(@user.id).provider.blank?
      #is_facebook_account = !@user.provider.blank?
    else
      is_facebook_account = false
    end


       successfully_updated = if !is_facebook_account
                             @user.update_with_password(user_params)
                           else
                             @user.update_without_password(user_params)
                           end

    if successfully_updated
      # Sign in the user bypassing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to root_path
    else
      render 'edit'
    end
  end
  protected

  def update_resource(resource, user_params)
    resource.update_without_password(user_params)
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :number,  :password, :password_confirmation, :number, :current_password, :admin => false)
  end
end