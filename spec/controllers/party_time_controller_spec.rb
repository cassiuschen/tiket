require 'rails_helper'

RSpec.describe PartyTimeController, :type => :controller do

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET config" do
    it "returns http success" do
      get :config
      expect(response).to have_http_status(:success)
    end
  end

end
