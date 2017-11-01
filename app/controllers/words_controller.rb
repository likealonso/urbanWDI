class WordsController < ApplicationController
    before_action :authorize, only: [:new, :create, :edit]
    def index
        @words = Word.all
        @word = @words.first
        @definition = Definition.new
        
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
        # search_term = params[:name]
        # search_term_no_s =
        # @word = search_term || search_term_no_s
        query = ActiveRecord::Base.connection.quote(params[:name])
        sql = "LOWER(name) = LOWER(#{query})"
        @word = Word.where(sql)[0]

        if @word
            render action: 'show'
        else
            redirect_to new_word_path, alert: 'That word has not been defined yet. Want to add it?' if @word.nil?
            
        end
    end

    def random
        offset = rand(Word.count)
        @word = Word.offset(offset).first
        @definition = Definition.new
        redirect_to word_path(@word)
    end

    private
        def word_params
            params.require(:word).permit(:name, definitions_attributes:[:content])
        end

end