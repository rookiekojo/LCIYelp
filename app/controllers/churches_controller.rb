class ChurchesController < ApplicationController
  before_action :set_church, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:search, :index, :show]
  before_action :check_user, except: [:search, :index, :show]

  def search
  if params[:search].present?
    @church = Church.search(params[:search])
  else
    @church = Church.all
  end
end

  # GET /churches
  # GET /churches.json
  def index
    @church = Church.all.order("created_at ASC").paginate(:page => params[:page], :per_page => 10) 
  end

  # GET /churches/1
  # GET /churches/1.json
  def show
    @reviews = Review.where(church_id: @church.id).order("created_at DESC")
      if @reviews.blank?
          @avg_rating = 0
      else
        @avg_rating = @reviews.average(:rating).round(2)
      end
  end

  # GET /churches/new
  def new
    @church = Church.new
  end

  # GET /churches/1/edit
  def edit
  end

  # POST /churches
  # POST /churches.json
  def create
    @church = Church.new(church_params)

    respond_to do |format|
      if @church.save
        format.html { redirect_to @church, notice: 'Church was successfully created.' }
        format.json { render :show, status: :created, location: @church }
      else
        format.html { render :new }
        format.json { render json: @church.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /churches/1
  # PATCH/PUT /churches/1.json
  def update
    respond_to do |format|
      if @church.update(church_params)
        format.html { redirect_to @church, notice: 'Church was successfully updated.' }
        format.json { render :show, status: :ok, location: @church }
      else
        format.html { render :edit }
        format.json { render json: @church.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /churches/1
  # DELETE /churches/1.json
  def destroy
    @church.destroy
    respond_to do |format|
      format.html { redirect_to churches_url, notice: 'Church was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_church
      @church = Church.find(params[:id])
    end

     def check_user
      unless current_user.admin?
        redirect_to church_path(@church), alert: "Sorry, only admins can do that"
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def church_params
      params.require(:church).permit(:name, :address, :phone, :resident_Pastor, :image)
    end
end
