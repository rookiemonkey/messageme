import consumer from "./consumer"
import MessageReceiver from '../components/messageReceiver'
import MessageSender from '../components/messageSender'

const rawUrlParams = window.location.search
const parsedUrlParams = new URLSearchParams(rawUrlParams);
const conversationId = parsedUrlParams.get('conversation_id')
const otherUserId = window.location.pathname.slice(1)

window.websocket_connection = consumer.subscriptions.create({
  channel: 'ChatroomChannel',
  conversation_id: conversationId
}, {
  received(data) {
    const { updated_at } = data
    const { user_id } = data.message

    const conversationItemMessage = document.querySelector(`[data-message="${otherUserId}"]`)
    const conversationItemDate = document.querySelector(`[data-updatedat="${otherUserId}"]`)
    conversationItemMessage.innerHTML = `${data.message.body.substring(0, 38)} ...`
    conversationItemDate.innerHTML = updated_at

    if (user_id == otherUserId) new MessageReceiver(data.message).mount()
    if (user_id != otherUserId) new MessageSender(data.message).mount()
  }
});
