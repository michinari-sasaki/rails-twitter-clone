class Post < ApplicationRecord
  validates:content,{presence: true, length: {maximum: 140}}
  validates:user_id,{presence: true}

  def user
    #find_by(id: @post.user_id) 同義
    return User.find_by(id: self.user_id)
  end
end
