require 'rails_helper'

RSpec.describe EventsController, :type => :controller do

  describe "GET show" do
    it "returns http success" do
      e = Event.create(short_name: "test_case1", name: "Test Case")
      get :show, shortname: "test_case1"
      expect(response).to have_http_status(:success)
    end
  end
end