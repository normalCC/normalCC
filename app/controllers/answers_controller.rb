class AnswersController < ApplicationController
  before_action :find_answer, only: [:update, :destroy]
  before_action :find_question, only: [:update, :destroy]

  def create
    @answer = Answer.new answer_params
  end

  def update
    #find_answer
    #find_question

    if @answer.update answer_params

    else

    end

  end

  def destroy
    @answer.destroy

  end

  private

    def find_answer
      @answer = Answer.find(params[:id])
    end

    def find_question
      @question = @answer.question
    end

    def answer_params
      params.require(:answer).permit(:title)
    end

end
