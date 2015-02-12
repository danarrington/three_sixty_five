class FeatureAnnouncmentsController < ApplicationController
  before_action :set_feature_announcment, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  before_filter do 
    redirect_to :new_user_session_path unless current_user && current_user.admin?
  end

  # GET /feature_announcments
  # GET /feature_announcments.json
  def index
    @feature_announcments = FeatureAnnouncment.all
  end

  # GET /feature_announcments/1
  # GET /feature_announcments/1.json
  def show
  end

  # GET /feature_announcments/new
  def new
    @feature_announcment = FeatureAnnouncment.new
  end

  # GET /feature_announcments/1/edit
  def edit
  end

  # POST /feature_announcments
  # POST /feature_announcments.json
  def create
    @feature_announcment = FeatureAnnouncment.new(feature_announcment_params)

    respond_to do |format|
      if @feature_announcment.save
        format.html { redirect_to @feature_announcment, notice: 'Feature announcment was successfully created.' }
        format.json { render :show, status: :created, location: @feature_announcment }
      else
        format.html { render :new }
        format.json { render json: @feature_announcment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /feature_announcments/1
  # PATCH/PUT /feature_announcments/1.json
  def update
    respond_to do |format|
      if @feature_announcment.update(feature_announcment_params)
        format.html { redirect_to @feature_announcment, notice: 'Feature announcment was successfully updated.' }
        format.json { render :show, status: :ok, location: @feature_announcment }
      else
        format.html { render :edit }
        format.json { render json: @feature_announcment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feature_announcments/1
  # DELETE /feature_announcments/1.json
  def destroy
    @feature_announcment.destroy
    respond_to do |format|
      format.html { redirect_to feature_announcments_url, notice: 'Feature announcment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feature_announcment
      @feature_announcment = FeatureAnnouncment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def feature_announcment_params
      params.require(:feature_announcment).permit(:name, :text)
    end
end
