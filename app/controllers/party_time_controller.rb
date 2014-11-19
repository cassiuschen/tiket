class PartyTimeController < ApplicationController
  before_action :authenticate_user!
  before_action :must_be_admin

  def index
    @collection = Collection.where(id: Party.collection_id).last
    @admissions = @collection ? @collection.admissions : []
  end
end
