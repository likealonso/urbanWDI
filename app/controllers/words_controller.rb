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
        @word = Word.find(params[:id])
        @definition = Definition.new
        # @user = Definition.find(params[:id])
    end

    def new
        @word = Word.new
        # @word.definitions.build
        @words = Word.all
        # @definition = Definition.new
        # @definition = @word.definitions.new
    end

    def create
        @word = Word.new(word_params)
        @word.user = current_user
        if @word.save
            @word.definitions.create(content: params[:definition], user: current_user)
            redirect_to root_path
        else
            render :new
        end
    end

    def search
        @definition = Definition.new
        @words = Word.all
        @word = Word.find_by_name(params[:name])
        if @word
            render action: 'show'
        else
            redirect_to new_word_path, alert: 'That word has not been defined yet. Want to add it?' if @word.nil?
            
        end
    end

    private
        def word_params
            params.require(:word).permit(:name)
        end

end