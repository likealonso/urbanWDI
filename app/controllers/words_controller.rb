class WordsController < ApplicationController
    def index
        @words = Word.all
        # @words = Word.all
        # if params[:name]
        #   @posts = Word.search(params[:name]).order("created_at DESC")
        # else
        #   @posts = Word.all.order('created_at DESC')
        # end
        # @word = Word.first
    end

    def show
        @words = Word.all  
        @word = Word.find(params[:id])
        @definition = Definition.find(params[:id])
        @definition = @word.definitions.find(params[:id])
    
        
    end

    def new
        @word = Word.new
        # @word.definitions.build
        @definition = @word.definitions.build
        @words = Word.all
        # @definition = Definition.new
        # @definition = @word.definitions.new

    end

    def create
        @words = Word.all
        @word = Word.new(word_params)
        # @word.definitions.build
        if @word.save
            redirect_to root_path
        else
            render :new
        end

    end

    def search
        @words = Word.all
        @word = Word.find_by_name(params[:name])
        if @word
            render action: 'show'
        else
            redirect_to new_word_path
        end
    end

    private
        def word_params
            params.require(:word).permit(:name, :user_id, definitions_attributes: [:content, :user_id, :word_id])
        end

end