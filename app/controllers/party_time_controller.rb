class PartyTimeController < ApplicationController

  def index
    @collection = Collection.where(id: Party::COLLECTION_ID).last
    @admissions = @collection ? @collection.admissions : []
  end
end
