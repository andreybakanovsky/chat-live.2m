import consumer from "./consumer"

consumer.subscriptions.create({ channel: "AppearanceChannel" }, {
  initialized() {
    this.update = this.update.bind(this)
  },

  connected() {
    this.install()
    this.update()
  },

  disconnected() {
    this.uninstall()
  },

  rejected() {
    this.uninstall()
  },

  update() {
    document.visibilityState === "visible" && document.hasFocus() ? this.online() : this.away()
  },

  online() {
    this.perform("online")
  },

  away() {
    this.perform("away")
  },

  install() {
    window.addEventListener("focus", this.update)
    window.addEventListener("blur", this.update)
    document.addEventListener("turbo:load", this.update)
    document.addEventListener("visibilitychange", this.update)
  },

  uninstall() {
    window.removeEventListener("focus", this.update)
    window.removeEventListener("blur", this.update)
    document.removeEventListener("turbo:load", this.update)
    document.removeEventListener("visibilitychange", this.update)
  }
})
