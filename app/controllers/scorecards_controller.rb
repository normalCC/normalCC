class ScorecardsController < ApplicationController
  before_action :find_answer, only: [:create, :destroy]

  def create
    #find_answer
    scorecard = @answer.scorecards.new
    scorecard.user = current_user

    if scorecard.save

    else

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
      @answer = Answer.find(params[:answer_id])
    end

end