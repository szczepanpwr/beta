class AdoptionsController < ApplicationController
  before_action :set_animal
  before_action :set_adoption, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  # GET /adoptions or /adoptions.json
  def index
    @adoptions = Adoption.all
  end

  # GET /adoptions/1 or /adoptions/1.json
  def show
  end

  # GET /adoptions/new
  def new
    @adoption = Adoption.new
  end

  # GET /adoptions/1/edit
  def edit
  end

  # POST /adoptions or /adoptions.json
  def create
    @adoption = Animal.find(params[:animal_id])
    @adoption = @animal.adoptions.create(adoption_params)
    @adoption.user = current_user
    #@adoption = Adoption.new(adoption_params)

    if @adoption.save
      flash[:notice] = "Adoption request was successfully created."
      redirect_to animal_path(@animal)
    else
      flash[:notice] = "Adoption request was not created."
      redirect_to animal_path(@animal)
    end
  end

  # PATCH/PUT /adoptions/1 or /adoptions/1.json
  def update
    respond_to do |format|
      if @adoption.update(adoption_params)
        format.html { redirect_to adoption_url(@adoption), notice: "Adoption was successfully updated." }
        format.json { render :show, status: :ok, location: @adoption }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @adoption.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /adoptions/1 or /adoptions/1.json
  def destroy
    @adoption = @animal.adoptions.find(params[:id])
    @adoption.destroy

    redirect_to animal_path(@animal)

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_adoption
      @adoption = Adoption.find(params[:id])
    end

    def set_animal
      @animal = Animal.find(params[:animal_id])
    end

    # Only allow a list of trusted parameters through.
    def adoption_params
      params.require(:adoption).permit(:name, :email, :description)
    end
end
