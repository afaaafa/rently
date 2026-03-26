import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.element.style.cursor = "pointer"
  }

  navigate(event) {
    const url = this.element.dataset.url
    if (url) window.location.href = url
  }
}
