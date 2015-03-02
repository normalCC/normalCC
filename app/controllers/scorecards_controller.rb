class ScorecardsController < ApplicationController
  before_action :find_answer, only: [:create, :destroy]
  before_action :logged_in_user
  def create
    # render text: params

    scorecard = @answer.scorecards.new
    scorecard.user = current_user
    # render json: output_ar(@answer)
    if scorecard.save
      @show_graph = true  # now that the user has chosen their answer, show the graph.
      redirect_to question_path(@answer.question)
    else
      render question_path(@answer.question), notice: "Something went wrong, we couldn't save your answer."
    end
  end

  def destroy
    #find_answer
    scorecard = @answer.scorecards.find(params[:id])
    if scorecard.destroy

    else

    end
  end

  private

    def find_answer
      @answer = Answer.find(params[:format])
    end

end