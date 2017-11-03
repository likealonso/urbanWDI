class PagesController < ApplicationController
    def show
        @words = Word.all
        @word = @words.first
        @definition = Definition.new
        @new_word = Word.new
        render "pages/#{params[:page]}"
    end

end
