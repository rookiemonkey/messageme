class SearchItem {
  constructor(user) {
    this.user = user
    this.link = this.user.conversation_id
      ? `/${this.user.id}?conversation_id=${this.user.conversation_id}`
      : `/${this.user.id}/new`
  }

  render() {
    return `
      <a href="${this.link}" data-user="${this.user.id}" class="list-group-item list-group-item-action rounded-0" style="border-color: transparent" >
        <div class="media d-flex align-items-center">
          <img src="https://res.cloudinary.com/mhmd/image/upload/v1564960395/avatar_usae7z.svg" alt="user" width="50" class="rounded-circle">
          <div class="media-body ml-4">
            <div class="d-flex align-items-center justify-content-between mb-1">
              ${this.user.username}
            </div>
          </div>
        </div>
      </a>
    `
  }
}

export default SearchItem