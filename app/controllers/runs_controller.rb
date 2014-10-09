class RunsController < ApplicationController

  before_action :authenticate_user!

  def create
    run = Run.new(run_params)
    if run.save
      current_user.total_distance += run.distance
      current_user.save
    else
      return render text: 'whoops', status: 422
    end
    render text: 'hi'
  end


  private

  def run_params
    params.require(:run).permit(:id, :distance).merge(user_id: current_user.id)
  end
end
