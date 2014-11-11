class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  def to_json
    user = User.find(user_id)
    {
      content: content,
      created_at: created_at,
      author: {
        name: user.email,
        avatar: "" # Need to be Fixed
      }
    }
  end
end
