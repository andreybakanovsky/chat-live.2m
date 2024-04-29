import consumer from "./consumer"

document.addEventListener('turbo:load', () => {
  console.log('event')
  const element = document.getElementById('chat-token')
  if (!element) {
    return
  }
  const token = element.getAttribute('data-chat-token')
  consumer.subscriptions.subscriptions.forEach((subscription) => {
    consumer.subscriptions.remove(subscription)
  })


  consumer.subscriptions.create(
    { channel: "ChatChannel", token: token }, {
    connected() {

    },

    disconnected() {
    },

    received(data) {
      console.log(data)

      const user_id_element = document.getElementById('user-id')
      const sender_id = Number(user_id_element.getAttribute('data-user-id'))

      let message_html

      if (sender_id === data.message.sender_id) {
        message_html = data.my_message
      } else {
        message_html = data.their_message
      }

      const messageContainer = document.getElementById('messages')
      messageContainer.innerHTML = messageContainer.innerHTML + message_html

      document.getElementById('message-input').value = ""
    }
  })
})