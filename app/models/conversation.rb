class Conversation < ApplicationRecord
  belongs_to :user_one, class_name: 'User'
  belongs_to :user_two, class_name: 'User'
  has_many :messages, dependent: :destroy

  def who_talks_to(current_user)
    return User.find(user_one.id) if user_two.id == current_user.id
    return User.find(user_two.id) if user_one.id == current_user.id
  end
end
