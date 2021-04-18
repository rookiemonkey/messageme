5.times { |i| User.create(username: "User #{i}", password: '987654321') }

User.all.each do |user|
  other_users = User.where.not(id: user.id)

  other_users.each do |other_user|

    next if user.existing_conversation_with(other_user)
    
    conversation = Conversation.create(user_one: user, user_two: other_user)

    2.times { |i| conversation.messages.create(body: "A Message from #{user.username} for #{other_user.username}", user: user) }
    2.times { |i| conversation.messages.create(body: "A Message from #{other_user.username} for #{user.username}", user: other_user) }
    2.times { |i| conversation.messages.create(body: "A Message from #{user.username} for #{other_user.username}", user: user) }
    3.times { |i| conversation.messages.create(body: "A Message from #{other_user.username} for #{user.username}", user: other_user) }

  end
end

2.times { |i| User.create(username: "Unknown #{i}", password: '987654321') }