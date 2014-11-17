class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :comments
  has_many :admissions

  def self.find_or_create(email, cucId)
    puts "============================== USER FIND OR CREATE ==============="
    user = User.where(email: email).last || User.create(email: email, cuc_no: cucId, password: cucId, password_confirmation: cucId)
    puts "================= FIND A USER ==============="
    puts "================= #{user.id.to_s} ==============="
    user
  end
end
