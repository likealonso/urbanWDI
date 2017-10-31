class DefinitionsController < ApplicationController
    # before_action :load_word
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

    private

    def definition_params
        params.require(:definition).permit(:content, :word_id, :user_id)
    end

    # def load_word
    #     @word = Word.find(params[:word_id])
        
    # end

end