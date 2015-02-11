class RunsController < ApplicationController

  before_action :authenticate_user!
  skip_before_filter :verify_authenticity_token, :only => [:create]

  def create
    run = Run.new(run_params)
    run.run_date = DateTime.now
    if run.save
      current_user.total_distance += run.distance
      current_user.save
    else
      return render text: 'whoops', status: 422
    end
    redirect_to user_root_path
  end

  def index
    @runs = current_user.runs.order(run_date: :desc).page(params[:page]).per(10)
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

  def destroy
    run = Run.find(params[:id])
    if run.user != current_user
      return render json:{}, status: :unauthorized
    end

    run.destroy
    run.user.recalculate_total_distance!
    render json: {id:run.id}, status: :ok
  end

  private

  def run_params
    merged_params = params.require(:run).permit(:id, :distance, :runtype, :run_date)
      .merge( user_id: current_user.id)
    if merged_params[:run_date]
      merged_params[:run_date] = Date.parse(merged_params[:run_date])
    end
    merged_params
  end
end
