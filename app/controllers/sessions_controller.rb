class SessionsController < ApplicationController
  skip_forgery_protection

  def login
    user = User.find_by(id: params[:id])

    if user
      session[:user_id] = user[:id];
      render json: {messege: "login successfully"}
    else
      render json: {messege: "wrong credentials"},status: 401
    end
  end

  def logout
    if (session[:user_id] == params[:id].to_i)
      session.delete(:user_id)
      render json: {messege: "logout successfully"}
    else
      render json: {messege: "user already logout"}
    end
  end

end
