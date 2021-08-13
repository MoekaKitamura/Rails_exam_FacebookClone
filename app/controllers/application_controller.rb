class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    include SessionsHelper
    before_action :login_required
    private
    def login_required
        redirect_to new_session_path, alert: "You have to log in." unless current_user
    end
    # def already_logged_in? チェック
    #     redirect_to user_path(@user.id), alert: "You are already logged in." if current_user
    # end


    
    def  same_user?
        @picture.user_id == current_user.id
    end
end
