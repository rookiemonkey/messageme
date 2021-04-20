const conversationLinks = document.querySelectorAll('.conversation-item')

window.disconnect_websocket_then_redirect = event => {
  const path = event.path || (event.composedPath && event.composedPath())
  const parent = path.find(element => { if (element.dataset.link) return element })

  if (window.websocket_connection) window.websocket_connection.unsubscribe()

  location.href = parent.dataset.link
}

conversationLinks.forEach(link => link.addEventListener('click', window.disconnect_websocket_then_redirect))