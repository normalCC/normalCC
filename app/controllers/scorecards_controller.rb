class ScorecardsController < ApplicationController
  before_action :find_answer, only: [:create, :destroy]
  before_action :logged_in_user
  def create
    # render text: params
    @question = @answer.question
    @scorecard = @answer.scorecards.new
    @scorecard.user = current_user
    # render json: output_ar(@answer)
    if @scorecard.save
      # render text: params
      # create.js {render js: "alert("success");"} 
      # render js: "alert("success");"
      # render create.js, status: :created
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