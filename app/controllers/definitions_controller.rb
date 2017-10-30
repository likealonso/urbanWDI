class DefinitionsController < ApplicationController
    before_filter :load_word
    def index
        @definitions = @word.definitions.all
    end

    def show
        @definition = @word.definitions.find(params[:id])
    end

    def new
        @definition = @word.definitions.new
    end

    def create
        @definition = @word.definitions.new(params[:definition])
    end

    private

    def definition_params
        params.require(:definition).permit(:content, :word_id, :user_id)
    end

    def load_word
        @word = Word.find(params[:word_id])
    end

end