class QuestionsController < ApplicationController
  before_action :find_question, only: [:edit, :update, :show, :destroy]

  def new
    @question = Question.new
    3.times { @question.answers.build }
  end

  def create
    @question = Question.new question_params
    if @question.save
      redirect_to @question, notice: "Question created successfully."
    else
      3.times { @question.answers.build }
      flash[:alert] = "Question FAILED to create."
      render :new
    end
  end

  def edit
    #find_question

    remaining = 3 - @question.answers.count
    remaining.times { @question.answers.build }
  end

  def update
    #find_question
    if @question.update question_params
      redirect_to @question, notice: "Question updated successfully."
    else
      flash[:alert] = "Campaign FAILED to update"
      render :edit
    end
  end

  def show
    find_question
    # find all the data for this question, to generate graph
    # @rawData2 =  @question.graph_data
  end

  def index
    #@entire_questions = Question.all
    @questions = Question.all
    #@questions = Question.search(params[:search])
    #@questions = Question.all 
    # Patching all Question
    #@Question = Question.where(id: params[:id]) if params[:id].present?
    # Find By Id (For paginating, 'where' statement result is Question ActiveRecord::Relationship )
    @questions = @questions.search(params[:search]) if params[:search].present?
    @questions = @questions.text_search(params[:query]) if params[:query].present?#.page(params[:page]).per_page(3)
    # Search using Keyword

    #if (Question.count >= 3)
    #  @questions_recent = Question.recent(3)
    #else
    #  @questions_recent = @entire_questions
    #end
  end

  def destroy
    #find_question
    @question.destroy
    redirect_to questions_path, notice: "Question deleted successfully."
  end


  private
    def find_question
      @question = Question.find(params[:id])
    end
    def question_params
      params.require(:question).permit( :title, 
                                        {country_ids: []},
                                        {answers_attributes: 
                                          [ :id, :title, :_destroy ] } )
    end
end
