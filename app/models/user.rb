class User < ActiveRecord::Base
  enum role: {
           user: 0,
           leader: 1,
           orgnization: 2,
           admin: 3
       }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :comments
  has_many :admissions

  validates :cuc_no, uniqueness: true

  def self.find_or_create(email, cucId)
    puts "============================== USER FIND OR CREATE ==============="
    user = User.where(email: email).last || User.create(email: email, cuc_no: cucId, password: cucId, password_confirmation: cucId)
    puts "================= FIND A USER ==============="
    puts "================= #{user.id.to_s} ==============="
    user
  end
end
