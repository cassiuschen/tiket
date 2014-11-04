class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  include Rails.application.routes.url_helpers

  # GET /ar/1
  # GET /ar/1.json
  def show
  end

  # GET /ar/new
  def new
    @event = Event.new
  end

  # GET /ar/1/edit
  def edit
  end

  # POST /ar
  # POST /ar.json
  def create
    @event = Event.new(evnet_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ar/1
  # PATCH/PUT /ar/1.json
  def update
    respond_to do |format|
      if @event.update(evnet_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ar/1
  # DELETE /ar/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find_by_short_name(params[:shortname]) || Event.find(params[:shortname])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def evnet_params
      params.require(:event).permit(:name, :des, :cover, :short_name)
    end
end
