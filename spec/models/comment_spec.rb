require 'rails_helper'

RSpec.describe Comment, :type => :model do
  describe "check :to_json" do
    it "should return correct json" do
      user = User.create(email: 'test@test.com', password: 'thisisatest', password_confirmation: 'thisisatest')
      time = Time.now
      comment = user.comments.create(event_id: 1, content: "This is a test!", created_at: time)
      json = {
          content: "This is a test!",
          created_at: time,
          author: {
              name: user.email,
              avatar: ""
          }
      }

      expect(comment.to_json).equal? json
    end
  end
end
