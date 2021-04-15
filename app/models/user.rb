class User < ApplicationRecord
  validates :username, presence: true, length: { minimum: 3, maximum: 15 }, uniqueness: { case_sensitive: false }
  has_many :messages, dependent: :destroy
  has_secure_password

  def existing_conversation_with(user_id)
    return nil if user_id == self.id

    type_one = Conversation.where(user_one_id: user_id, user_two_id: self.id)
    type_two = Conversation.where(user_one_id: self.id, user_two_id: user_id)
    return type_one.first unless type_one.first.nil?
    return type_two.first unless type_two.first.nil?
  end
end
