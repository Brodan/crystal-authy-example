require "../helpers/authy"

class VerifyController < ApplicationController
  def verify
    user = User.find_by(id: session[:tmp_user_id])

    if user && verify_authy_token user.authy_user_id, verification_params.validate!["authy_token"]
      session[:user_id] = user.id
      session[:is_verified] = true
      flash[:info] = "Successfully logged in!"
      redirect_to "/"
    else
      flash[:danger] = "Invalid Authy token!"
      session.delete(:tmp_user_id)
      redirect_to "/"
    end
  end

  private def verification_params
    params.validation do
      required :authy_token
    end
  end
end
