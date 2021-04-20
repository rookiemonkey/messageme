class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?, :format_date
  include Exceptions::ApplicationErrors
  rescue_from AccountError, with: :respond_error

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    return if logged_in?

    flash[:alert] = 'You must be logged in to perform that action'
    redirect_to session_new_path
  end

  def format_date(date)
    date.strftime('%a, %b %d %Y, at %I:%M %p')
  end

  def account_params
    params.require(:user).permit(:username, :password)
  end

  def respond_success(message, path)
    flash[:notice] = message
    redirect_to(path)
  end

  def redirect_if_logged_in
    redirect_back(fallback_location: '/', alert: 'You are still logged in!') if self.logged_in?
  end

  def set_raw_conversations
    @raw_conversations = Conversation.where(user_one: current_user).or(Conversation.where(user_two: current_user))
  end

  def set_conversations
    @conversations = @raw_conversations.map do |conversation|
      last_message = conversation.messages.last
      {
        other_user: conversation.who_talks_to(current_user),
        conversation_id: conversation.id,
        last_message: last_message ? "#{last_message.body[0..40]} ..." : ''
      }
    end
  end

  protected

  def respond_error(error)
    flash[:alert] = error.message
    redirect_to(error.path)
  end
end
