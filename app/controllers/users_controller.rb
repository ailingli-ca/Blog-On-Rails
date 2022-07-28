class UsersController < ApplicationController
    before_action :find_user, only: [:edit, :update]
    before_action :authenticate_user!, only: [:edit, :update]

    def new
        @user = User.new
    end
    def create
        @user = User.new params.require(:user).permit(
          :name,
          :email,
          :password,
          :password_confirmation
        )

        if @user.save
            session[:user_id] = @user.id
            flash.notice = "Signed up!"
            redirect_to root_path
        else
            render :new, status: 303
        end
    end

      # ===============EDIT==========================
    def edit
    end

    def update
        if @user.update(user_params)
        redirect_to root_path, { status: 303, notice: 'User profile updated successfully' }
        else 
        render :edit, status: 303
        end
    end


    private

    def find_user
        @user = current_user
    end

    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
