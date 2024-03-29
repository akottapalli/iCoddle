class PetsController < ApplicationController
  # GET /pets
  # GET /pets.json
  def index
    @pets = current_user.pets

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pets }
    end
  end

  # GET /pets/1
  # GET /pets/1.json
  def show
    @pet = Pet.find(params[:id])

    respond_to do |format|
      if (current_user.id == @pet.user_id)
        format.html # show.html.erb
        format.json { render json: @pet }
      else
        flash[:error] = "You are only authorised to view your own pets' profiles. Please login as the owner to view this pet."
        redirect_to pets_url
      end
    end
  end

  # GET /pets/new
  # GET /pets/new.json
  def new
    @pet = Pet.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pet }
    end
  end

  # GET /pets/1/edit
  def edit
    @pet = Pet.find(params[:id])

    if (current_user.id != @pet.user_id)
      flash[:error] = "You are only authorised to edit your own pets' profiles. Please login as the owner to edit this pet."
      redirect_to pets_url
    end
  end

  # POST /pets
  # POST /pets.json
  def create
    @pet = Pet.new(params[:pet])

    respond_to do |format|
      if @pet.save
        format.html { redirect_to @pet, notice: 'Pet profile was successfully created.' }
        format.json { render json: @pet, status: :created, location: @pet }
      else
        format.html { render action: "new" }
        format.json { render json: @pet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pets/1
  # PUT /pets/1.json
  def update
    @pet = Pet.find(params[:id])
    # @pet_x = current_user.pets.where(:id => params[:id])

    respond_to do |format|
      if @pet.update_attributes(params[:pet])
        format.html { redirect_to @pet, notice: 'Pet profile was successfully saved.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @pet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pets/1
  # DELETE /pets/1.json
  def destroy
    @pet = Pet.find(params[:id])
    @pet.destroy

    respond_to do |format|
      format.html { redirect_to pets_url }
      format.json { head :ok }
    end
  end
end
