class User < ApplicationRecord
  attr_accessor :activation_token
  has_secure_password
  #before_action :create_activation_digest
  validates:name,{presence: true}
  validates:email,{presence: true, uniqueness: true}
  validates:password,{presence: true}

  def post
    return Post.find_by(user_id: self.id)
  end

  # def downcase_email
  #   self.email = email.downcase
  # end

  # def create_activation_digest
  #   self.activation_token = User.new_token
  #   self.activation_digest = User.digest(activation_token)
  # end

  # 与えられた文字列のハッシュ値を返す テスト送信では使わないみたい？？一旦コメントアウト
  # def User.digest(string)
  #   cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
  #                                                 BCrypt::Engine.cost
  #   BCrypt::Password.create(string, cost: cost)
  # end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

end
