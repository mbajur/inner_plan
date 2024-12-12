import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ['input', 'form', 'toggle']

  static values = {
    active: {
      type: Boolean,
      default: false
    }
  }

  connect() {
    this.element.addEventListener('shown.bs.dropdown', this.onDropdownShown.bind(this))
    this.element.addEventListener('hidden.bs.dropdown', this.onDropdownHidden.bind(this))
  }

  activeValueChanged(val) {
    if (val) {
      this.inputTarget.focus()
      this.toggleTarget.classList.add('active')
    } else {
      this.toggleTarget.classList.remove('active')
    }
  }

  onDropdownShown() {
    this.activeValue = true
  }

  onDropdownHidden() {
    this.activeValue = false
  }

  disconnect() {
    this.element.removeEventListener('shown.bs.dropdown', this.onDropdownShown.bind(this));
    this.element.removeEventListener('hidden.bs.dropdown', this.onDropdownHidden.bind(this));
  }

  submit() {
    this.formTarget.requestSubmit()
  }
}
