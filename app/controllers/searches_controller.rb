class SearchesController < ApplicationController
  before_action :logged_in_user
  def new 
    @search = Search.new
  end

  def create
    @search = Search.create!(search_params)
    #@search = Search.create!(params[:search])
    redirect_to @search
  end

  def show
    @search = Search.find(params[:id])
    @questions = Question.where(nil)
    @questions = @questions.time_search(@search.keywords) if @search.keywords.present?
    @questions = @questions.time_search(@search.title) if @search.title.present?
    @questions = @questions.time_search(@search.name) if @search.name.present?
    @questions = @questions.not_time(@search.part) if @search.part.present?
  end

    private 
      def search_params
        params.require(:search).permit(:title, :keywords, :name, :part)
        #@search = Search.find(params[:search])
      end
end
