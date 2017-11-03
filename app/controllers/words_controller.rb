class WordsController < ApplicationController
    before_action :authorize, only: [:create, :edit]
    def index
        @words = Word.all
        @word = @words.first
        @definition = Definition.new
        @new_word = Word.new
        
    end

    def show
        @word = Word.find(params[:id])
        @definition = Definition.new
        @new_word = Word.new
    end

    def new
        @word = Word.new
        @words = Word.all
    end

    def create
        @word = Word.new(word_params)
        @word.user = current_user
        if @word.save
            @word.definitions.create(content: params[:definition], user: current_user)
            redirect_to word_path(@word)
        else
            render :new
        end
    end

    def edit
        @word = Word.find(params[:id])
        
    end

    def update
        @word = Word.find(params[:id])
        if @word.update_attributes(word_params)
          redirect_to word_path(@word)
        else
          render :edit
        end
    end

    def destroy
        @word = Word.find(params[:id])
        @word.destroy
        redirect_to words_path
    end

    def search
        @definition = Definition.new
        @words = Word.all
        @new_word = Word.new
        query = ActiveRecord::Base.connection.quote(params[:name])
        sql = "LOWER(name) = LOWER(#{query})"
        @word = Word.where(sql)[0]

        if @word
            render action: 'show'
        else
            redirect_to new_word_path, alert: "The word #{query} has not been defined yet. Want to add it?" if @word.nil?
            
        end
    end

    def random
        @word = Word.all.sample
        @definition = Definition.new
        redirect_to word_path(@word)
    end

    private
        def word_params
            params.require(:word).permit(:name, definitions_attributes:[:content])
        end

end