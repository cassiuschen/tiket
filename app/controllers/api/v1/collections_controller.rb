class Api::V1::CollectionsController < Api::V1::BaseController
  before_action :set_collection, only: [:show, :edit, :update, :destroy]
  include Rails.application.routes.url_helpers

  # GET /ar/1
  # GET /ar/1.json
  def show
  end

  # GET /ar/new
  def new
    @collection = Collection.new
  end

  # GET /ar/1/edit
  def edit
  end

  # POST /ar
  # POST /ar.json
  def create
    @event =
    @collection = Collection.new(evnet_params)

    respond_to do |format|
      if @collection.save
        format.html { redirect_to @collection, notice: 'Collection was successfully created.' }
        format.json { render :show, status: :created, location: @collection }
      else
        format.html { render :new }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ar/1
  # PATCH/PUT /ar/1.json
  def update
    respond_to do |format|
      if @collection.update(evnet_params)
        format.html { redirect_to @collection, notice: 'Collection was successfully updated.' }
        format.json { render :show, status: :ok, location: @collection }
      else
        format.html { render :edit }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ar/1
  # DELETE /ar/1.json
  def destroy
    @collection.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Collection was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_collection
      @collection = Collection.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def evnet_params
      params.require(:collection).permit(:name, :des, :cover, :short_name)
    end
end
