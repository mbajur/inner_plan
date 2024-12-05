import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ['form', 'toggler', 'defaultInput']

  static values = {
    formVisible: {
      type: Boolean,
      default: false
    }
  }

  formVisibleValueChanged(value) {
    if (value) {
      this.showForm()
    } else {
      this.hideForm()
    }
  }

  escPressed() {
    this.formVisibleValue = false
  }

  togglerClicked(e) {
    e.preventDefault()
    this.formVisibleValue = true
  }

  showForm() {
    this.formTarget.classList.remove('d-none')
    this.togglerTarget.classList.add('d-none')
    this.defaultInputTarget.focus()
  }

  hideForm() {
    this.formTarget.classList.add('d-none')
    this.togglerTarget.classList.remove('d-none')
  }
}
