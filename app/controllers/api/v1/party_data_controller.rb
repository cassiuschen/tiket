class Api::V1::PartyDataController < Api::V1::BaseController
  before_action :set_collection
  def data
    json = {
        attend: @collection.post_in.value,
        success: @collection.success.value,
        fail: @collection.post_in.value - @collection.success.value,
        leftTicket: @collection.maximum - @collection.admissions.all.size,
        rate: (@collection.success.value.to_f * 100.00 / @collection.post_in.value.to_f).round(2),
        status: Party.status,
        start_at: Party.start_at_humanize
    }
    render json: json
  end

  def list
    render json: @collection.name_list
  end

  def change_status
    (Party.can_attend?) ? (Party.fin) : (Party.start)
    render json: {status: 200}
  end

  def change_rate
    Party.rate = params[:newRate]
    render json: {status: 200}
  end

  def status
    render json: !!(Party.can_attend?)
  end

  private
  def set_collection
    @collection = Collection.find Party.collection_id
  end
end