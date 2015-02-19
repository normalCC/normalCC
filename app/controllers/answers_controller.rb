class AnswersController < ApplicationController
  before_action :find_answer, only: [:update, :destroy]
  before_action :find_question, only: [:update, :destroy]

  def create
    @answer = Answer.new answer_params
    if @answer.save
      redirect_to question_path(@question), notice: "Answer created successfully."
    else
      redirect_to question_path(@question), alert: "Answer FAILED to create."
    end
  end

  def update
    #find_answer
    #find_question
    if @answer.update answer_params
      redirect_to question_path(@question), notice: "Answer updated successfully."
    else
      redirect_to question_path(@question), alert: "Answer FAILED to update."
    end
  end

  def destroy
    @answer.destroy
    redirect_to questions_path, notice: "Answer deleted successfully."
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
