class UserController < ApplicationController
  getter user = User.new

  before_action do
    only [:show, :edit, :update, :destroy] { set_user }
  end

  def show
    render("show.slang")
  end

  def new
    render "new.slang"
  end

  def edit
    render("edit.slang")
  end

  def create
    puts user_params.validate!
    user = User.new user_params.validate!
    pass = user_params.validate!["password"]
    phone = user_params.validate!["phone_number"]
    country_code = user_params.validate!["country_code"]
    user.password = pass if pass
    user.phone_number = phone if phone
    user.country_code = country_code if country_code

    if user.save
      session[:user_id] = user.id
      redirect_to "/", flash: {"success" => "Created User successfully."}
    else
      flash[:danger] = "Could not create User!"
      render "new.slang"
    end
  end

  def update
    user.set_attributes user_params.validate!
    if user.save
      redirect_to "/", flash: {"success" => "User has been updated."}
    else
      flash[:danger] = "Could not update User!"
      render "edit.slang"
    end
  end

  def destroy
    user.destroy
    redirect_to "/", flash: {"success" => "User has been deleted."}
  end

  private def user_params
    params.validation do
      required :email
      optional :password
      required :phone_number
      required :country_code
    end
  end

  private def set_user
    @user = current_user.not_nil!
  end
end
