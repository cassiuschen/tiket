require 'rails_helper'

RSpec.describe User, :type => :model do
  describe "check :find_or_create" do
    it "should return exist user when exist" do
      user1 = User.create(email: 'test1@test.com', cuc_no: '1423101', password: 'thisisatest', password_confirmation: 'thisisatest')
      p1 = {
          email: 'test1@test.com',
          cucId: '1423101'
      }

      expect(User.find_or_create p1).equal? user1
    end

    it "should create a  user when not exist" do
      p1 = {
          email: 'test1@test.com',
          cucId: '1423101'
      }

      expect(User.find_or_create p1).equal? User.where(email: p1[:email]).last
    end
  end
end
