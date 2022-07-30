class UsersController < ApplicationController
    before_action :find_user, only: [:edit, :update, :edit_password, :update_password]
    before_action :authenticate_user!, only: [:edit, :update, :edit_password, :update_password]

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
    # ===============EDIT PASSWORD==========================
    def edit_password
    end

    def update_password
        if params[:new_password] != params[:current_password]
            if params[:new_password] == params[:new_password_confirmation]
              if @user&.authenticate params[:current_password]
                if @user&.update password: params[:new_password], password_confirmation: params[:new_password_confirmation]
                  redirect_to root_path, { status: 303, notice: 'Password updated successfully' }
                else
                  flash.now[:alert] = @user.errors.full_messages.join(', ')
                  render :edit_password, status: 303
                end
              else
                flash.now[:alert] = 'Current password wrong'
                render :edit_password, status: 303
              end
            else
              flash.now[:alert] = 'New password does not match'
              render :edit_password, status: 303
            end
        else
            flash.now[:alert] = 'New password cannot be the same as your current password'
            render :edit_password, status: 303
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
