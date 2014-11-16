class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :comments
  has_many :admissions

  def self.find_or_create(params)
    user = User.where(email: params[:email]).last || User.create(email: params[:email], cuc_no: params[:cucId], password: params[:cucId], password_confirmation: params[:cudID])
    user
  end
end
