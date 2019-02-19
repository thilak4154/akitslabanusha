class LoginController < ApplicationController

  def new
    # Present the login form
    @user = User.new
  end

  def signin
    # Get the role right
    if params[:role] == "Admin"
      role = User::IS_ADMIN
    elsif params[:role] == "Member"
      role = User::IS_MEMBER
    else
      # Shouldn't really get here
      role = 0
    end
    # User could both be a admin and a member
    alternate_role = User::IS_ADMIN | User::IS_MEMBER
    # Authenticate and redirect accordingly
    @user = User.where('isDeleted = false AND email = ? AND password = ? AND ( role = ? OR role = ?)', params[:email], params[:password], role, alternate_role)
    if @user[0]
      # Capture the email id for this session
      session[:email] = @user[0].email
      session[:role] = role
      session[:user_id] = @user[0].id
      logger.debug "Session variable has captured this email id : #{session[:email]}"
      # Render the member view
      if(role & User::IS_ADMIN > 0)
        render('admin_landing')
      elsif(role & User::IS_MEMBER > 0)
        render('member_landing')
      else
        # Shouldnt really get in here anytime. A sanity check !!
        flash[:notice] = "Login failed ! Please enter the credentials again !"
        redirect_to action: 'new'
      end
    else
      # Incorrect credentials
      flash[:notice] = "Login failed ! Please enter the credentials again !"
      redirect_to action: 'new'
    end
  end

  def signup_new
    @user = User.new
  end

  def signup_create
    @user = User.new(:name => params[:name], :email => params[:email], :password=> params[:password],:isDeleted=>FALSE,:role => User::IS_MEMBER)
    @existingUser = User.find_by_email(params[:email])
    if @existingUser
      if @existingUser.role & User::IS_MEMBER > 0
        flash[:notice] = "An account with email : #{params[:email]} already exists. Please use the original credentials to sign in. This user account is already a member account"
      else
        flash[:notice] = "An account with email : #{params[:email]} already exists. Please use the original credentials to sign in. Added the user account as a member account"
        @existingUser.update_column(:role, @existingUser.role | User::IS_MEMBER)
      end
      redirect_to action: 'new'

    else
        if @user.save(validate: true)
          # Capture the email id for this session
          session[:email] = @user.email
          session[:role] = @user.role
          session[:user_id]=@user.id
          logger.debug "login#signup_create : Session variable has captured this email id : #{session[:email]}"
          flash[:notice] = "Hi "+@user.name+ ", Your profile is created successfully."
          redirect_to action: 'member_landing'
        else
          flash[:notice] = "There was an error in creating profile."
          redirect_to action: 'signup_new'
        end
    end
  end

  # Edit profile
  def edit_profile_new
    user_logged_in?
    # Find the member's details
    logger.debug "Retrieving details for the user with the email ID : #{session[:email]}"
    @user = User.find_by_email(session[:email])
  end

  def update_profile
    @user = User.where('email = ?', session[:email])
    if @user[0]
      if @user[0].update_columns(user_params.delete_if { |k,v| v.blank? })
        flash[:notice] = "Updated the profile successfully"
        redirect_to action: 'edit_profile_new'
      else
        flash[:notice] = "There was an error updating the profile !"
        redirect_to action: 'edit_profile_new'
      end
    else
      logger.error "login#edit_profile : Couldn't find the user for editing profile"
    end
  end

  def logout
    session[:email] = nil
    session[:role] = nil
    session[:user_id] = nil
    redirect_to action: 'new'
  end

  # Stubs for landing views
  def member_landing
  end

  def admin_landing
  end

  def user_params
    params.require(:user).permit(:email, :name, :password)
  end
end

