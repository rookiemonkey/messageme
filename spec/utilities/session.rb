module Utilities
  module Session
    def login(resource)
      post session_create_path, params: { user: { username: resource.username, password: '987654321' } }
      follow_redirect!
    end
  end
end
