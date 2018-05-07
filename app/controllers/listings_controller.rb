class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy]

  # GET /listings
  # GET /listings.json
  def index
    @listings = Listing.all
    
    if params[:search]
      @listings = Listing.search(params[:search]).order("created_at DESC")
    else
      @listings = Listing.all.order(:name).paginate(:page => params[:page], :per_page => 6)
    end
  end

  # GET /listings/1
  # GET /listings/1.json
  def show
    @listing = Listing.find(params[:id])
  end

  # GET /listings/new
  def new
    @listing = Listing.new

    # authorization code
       allowed?(action: flash[:notice]= "You do not have permission to verify." , user: current_user)
     
  
  end

  # GET /listings/1/edit
  def edit
  end

  # POST /listings
  # POST /listings.json
  def create
    @listing = Listing.new(listing_params)

    respond_to do |format|
      if @listing.save
        format.html { redirect_to @listing, notice: 'Listing was successfully created.' }
        format.json { render :show, status: :created, location: @listing }
      else
        format.html { render :new }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end



  def verify
    @listing = Listing.find(params[:id])
    if @listing.verification == "false" || nil
      @listing.verification = 'true'
      @listing.save
      redirect_to :back
    else
      @listing.verification = 'false'
      @listing.save
      redirect_to :back
    end
  end


  # PATCH/PUT /listings/1
  # PATCH/PUT /listings/1.json
  def update
     
      if @listing.update(listing_params)
        respond_to do |format|
        format.html { redirect_to @listing, notice: 'Listing was successfully updated.' }
        format.json { render :show, status: :ok, location: @listing }
      end
      else
        respond_to do |format|
        format.html { render :edit }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1
  # DELETE /listings/1.json
  def destroy
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_url, notice: 'Listing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def listing_params
      params.require(:listing).permit(:name, :place_type, :property_type, :room_number, :bed_number, :guest_number, :country, :state, :city, :zipcode, :address, :price, :description, :verification, :user_id, images: [])
    end
end