export default class MessageSender {
  constructor(message) {
    this.message = message
    this.parent = document.querySelector('.chat-box')
  }

  DOMString() {
    return `
      <div class="media w-50 ml-auto mb-3">
        <div class="media-body">
          <div class="bg-primary rounded py-2 px-3 mb-2">
            <p class="text-small mb-0 text-white">${this.message.body}</p>
          </div>
          <p class="small text-muted">${this.message.created_at}</p>
        </div>
      </div>
    `
  }

  mount() {
    this.parent.insertAdjacentHTML('beforeend', this.DOMString())
  }
}
