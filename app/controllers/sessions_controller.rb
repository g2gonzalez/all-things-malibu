class SessionsController < ApplicationController

  def create
    user = User.find_by_email(params[:email])
    # If the user exists AND the password entered is correct.
    if user && user.authenticate(params[:password])
      # Save the user id inside the browser cookie. This is how we keep the user
      # logged in when they navigate around our website.
      session[:user_id] = user.id
      redirect_to root_path, flash: { success: "Welcome back #{current_user.username}!" }
    else
      # If user's login doesn't work, send them back to the login form.
      redirect_to login_path, flash: { warning: "Hmmm that wasn't right. Try again." }
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, flash: { danger: "See ya later alligator!" }
  end

end