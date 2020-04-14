require "../helpers/authy"

class SessionController < ApplicationController
  def new
    user = User.new
    render("new.slang")
  end

  def create
    user = User.find_by(email: params["email"].to_s)
    if user && user.authenticate(params["password"].to_s)

      if user.phone_number.nil? && user.country_code.nil?
        session[:user_id] = user.id
        session[:is_verified] = false
        redirect_to "/"
      else
        session[:tmp_user_id] = user.id
        send_OTP user.authy_user_id
        redirect_to "/verify"
      end

    else
      flash[:danger] = "Invalid email or password"
      user = User.new
      render("new.slang")
    end
  end

  def delete
    session.delete(:user_id)
    session.delete(:tmp_user_id)
    session.delete(:is_verified)
    flash[:info] = "Logged out. See ya later!"
    redirect_to "/"
  end
end
