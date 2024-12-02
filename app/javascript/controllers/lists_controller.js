import { Controller } from "@hotwired/stimulus";
import Sortable from "sortablejs"
import { patch } from "@rails/request.js"

export default class extends Controller {
  static targets = ['list'];

  connect() {
    this.sortable = Sortable.create(this.element, {
      handle: '.list-handle',
      group: 'list',
      onUpdate: this.onUpdate.bind(this)
    })
  }

  destroy() {
    this.sortable.destroy();
  }

  onUpdate({ item }) {
    const nextListEl = item.nextElementSibling;
    const nextListId = nextListEl ? nextListEl.dataset.id : null

    patch(item.dataset.updateUrl, {
      body: {
        list: { position: { before: nextListId } }
      }
    })
  }
}
