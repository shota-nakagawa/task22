class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(sessions_params[:password])
      log_in user
      redirect_to root_path, success: 'ログインに成功しました'
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :new
    end
  end

  def destroy
     log_out
     redirect_to root_url, info: 'ログアウトしました'
   end

   private
   def login_check 
     unless logged_in?
       flash[:alert] = "ログインしてください"
       redirect_to root_path
     end
   end

    def log_in(user)
     session[:user_id] = user.id
   end

   def sessions_params
     params.require(:session).permit(:email, :password)
     end

   def log_out
     session.delete(:user_id)
     @current_user = nil
   end
 end
