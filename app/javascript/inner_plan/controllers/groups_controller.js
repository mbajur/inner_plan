import { Controller } from "@hotwired/stimulus";
import Sortable from "sortablejs"
import { patch } from "@rails/request.js"

export default class extends Controller {
  static values = {
    listId: Number
  };

  connect() {
    this.sortable = Sortable.create(this.element, {
      handle: '.group-handle',
      group: 'group',
      onUpdate: this.onUpdate.bind(this),
      onAdd: this.onAdd.bind(this),
    })
  }

  destroy() {
    this.sortable.destroy();
  }

  onAdd({ item }) {
    const nextGroupEl = item.nextElementSibling;
    const nextGroupId = nextGroupEl ? nextGroupEl.dataset.id : null

    patch(item.dataset.updateUrl, {
      body: {
        list: {
          list_id: this.listIdValue,
          position: { before: nextGroupId }
        }
      }
    })
  }

  onUpdate({ item }) {
    const nextGroupEl = item.nextElementSibling;
    const nextGroupId = nextGroupEl ? nextGroupEl.dataset.id : null

    patch(item.dataset.updateUrl, {
      body: {
        list: { position: { before: nextGroupId } }
      }
    })
  }
}
