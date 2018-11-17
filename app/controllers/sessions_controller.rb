class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: permited_params[:email])
    if user && user.authenticate(permited_params[:password])
      session[:user_id] = user.id
      redirect_to root_url
    else
      @error = 'Email or password is invalid'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

  private

  def permited_params
    params.require(:user).permit!
  end

end
