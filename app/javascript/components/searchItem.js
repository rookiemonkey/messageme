class SearchItem {
  constructor(user) {
    this.user = user
    this.link = this.user.conversation_id
      ? `/${this.user.id}?conversation_id=${this.user.conversation_id}`
      : `/${this.user.id}/new`
  }

  render() {
    const element = document.createElement('a')
    element.href = '#'
    element.dataset.user = this.user.id
    element.dataset.link = this.link
    element.className = 'list-group-item list-group-item-action rounded-0'
    element.style.borderColor = 'transparent'

    // mount HTML string
    element.innerHTML = `
      <div class="media d-flex align-items-center">
        <img src="https://res.cloudinary.com/mhmd/image/upload/v1564960395/avatar_usae7z.svg" alt="user" width="50" class="rounded-circle">
        <div class="media-body ml-4">
          <div class="d-flex align-items-center justify-content-between mb-1">
            ${this.user.username}
          </div>
        </div>
      </div>
    `

    // mount event listener
    element.addEventListener('click', window.disconnect_websocket_then_redirect)

    return element
  }
}

export default SearchItem