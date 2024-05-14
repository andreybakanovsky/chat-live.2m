import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["content", "token", "recipientId" ]

    send() {
        if (this.contentTarget.value == '') return;

        window.channel.send({
            content: this.contentTarget.value,
            recipient_id: this.recipientIdTarget.value,
            token: this.tokenTarget.value
        })
       this.contentTarget.value = ''
    }
}
