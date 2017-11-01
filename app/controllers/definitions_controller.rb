class DefinitionsController < ApplicationController
    # before_action :load_word
    before_action :authorize, only: [:new, :create, :edit, :update, :destroy]
    def index
        @words = Word.all
        @definitions = @word.definitions.all
    end

    def show
        @definition = @word.definitions.find(params[:id])
    end

    def new
        @word = Word.new
        @definition = @word.definitions.new
    end

    def create
        @definition = Definition.new(content: params[:definition][:content])
        @definition.user = current_user
        @definition.word_id = params[:word_id]
        @definition.save
        redirect_to word_path(params[:word_id])
    end

    def edit
        @definition = Definition.find(params[:id])
        
       
    end

    def update
        @definition = Definition.find(params[:id])
        if @definition.update_attributes(definition_params) && @definition.user.id == current_user.id
          redirect_to word_path(@definition.word)
        else
          flash[:notice] = "You don't have access to edit this page"
          render :edit
        end
    end

    def destroy
        @definition = Definition.find(params[:id])
        @definition.destroy
        redirect_to word_path(@definition.word)
    end


    private

    def definition_params
        params.require(:definition).permit(:content, :word_id, :user_id)
    end

    # def load_word
    #     @word = Word.find(params[:word_id])
        
    # end

end