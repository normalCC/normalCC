class ScorecardsController < ApplicationController
  before_action :find_answer, only: [:create, :destroy]
  before_action :logged_in_user
  def create
    # render text: params

    scorecard = @answer.scorecards.new
    scorecard.user = current_user
    # render json: output_ar(@answer)
    if scorecard.save
      render nothing: true, status: :created
    else
      render nothing: true, status: :unprocessable_entity
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