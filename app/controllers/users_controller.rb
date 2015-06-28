class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :check_admin, except: [:edit, :update, :destroy]
  def index
    @users = User.all
  end
  def show
   if !@user
      redirect_to users_path, :notice => 'User not found'
   end
  end

  # GET /users/:id/edit
  def edit
    # authorize! :update, @user
  end

  # PATCH/PUT /users/:id.:format
  def update
    respond_to do |format|
      if @user.update(user_params)
        sign_in(@user == current_user ? @user : current_user, :bypass => true)
        format.html { redirect_to @user, notice: 'Your profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET/PATCH /users/:id/finish_signup
  ## def finish_signup
  # authorize! :update, @user
  # if request.patch? && params[:user] #&& params[:user][:email]
  #if @user.update(user_params)
  # @user.skip_reconfirmation!
  #  sign_in(@user, :bypass => true)
  #redirect_to @user, notice: 'Your profile was successfully updated.'
  #  else
  #  @show_errors = true
  #  end
  #  end
  #end

  # DELETE /users/:id.:format
  def destroy
    # authorize! :delete, @user
    @user.destroy
    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end
  def change_admin
    redirect_to tasks_path
  end
  private
  def set_user
    @user = User.find_by_username(params[:id])
  end

  def check_admin
    if !current_user.admin?
      redirect_to root_path, flash: {:notice => 'Only admins have permissions to look at users!'}
    end
  end



  def user_params
    accessible = [ :username, :email, :number, :current_password ] # extend with your own params
    accessible << [ :password, :password_confirmation ] #unless params[:user][:password].blank?
    params.require(:user).permit(accessible)
  end
end