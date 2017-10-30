class UsersController < ApplicationController
    before_action :authorize, except: [:index, :show, :new, :create]
    def index
        @users = User.all
        @words = Word.all
        @definitions = Definition.all
        
    end

    def show
        @user = User.find(params[:id])
        @word = Word.find(params[:id])
        @definition = Definition.find(params[:id])
    end

    def new
        @user = User.new
        @word = Word.new
        @words = Word.all
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            flash[:notice] = "You have successfully signed up!"
            redirect_to root_path
        else
            render :new
        end
    end

    private

        def user_params
            params.require(:user).permit(:name, :email, :password, :password_confirmation)
        end

end