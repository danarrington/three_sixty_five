class RunsController < ApplicationController

  before_action :authenticate_user!
  skip_before_filter :verify_authenticity_token, :only => [:create]

  def create
    run = Run.new(run_params)
    if run.save
      current_user.total_distance += run.distance
      current_user.save
    else
      return render text: 'whoops', status: 422
    end
    redirect_to user_root_path
  end

  def index
    @runs = current_user.runs.order(created_at: :desc).page(params[:page]).per(10)
  end

  def update
    run = Run.find(params[:id])
    if run.update_attributes(run_params)
      run.user.recalculate_total_distance!
      render json: {}, status: :ok
    else
      render json: run.errors.messages, status: :unprocessable_entity
    end
  end

  private

  def run_params
    params.require(:run).permit(:id, :distance, :runtype).merge(user_id: current_user.id)
  end
end
