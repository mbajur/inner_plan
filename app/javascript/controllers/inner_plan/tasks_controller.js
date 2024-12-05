import { Controller } from "@hotwired/stimulus";
import Sortable from "sortablejs"
import { patch } from "@rails/request.js"

export default class extends Controller {
  static values = {
    listId: Number
  };

  connect() {
    this.sortable = Sortable.create(this.element, {
      handle: '.task-handle',
      group: 'task',
      onUpdate: this.onUpdate.bind(this),
      onAdd: this.onAdd.bind(this),
    })
  }

  destroy() {
    this.sortable.destroy();
  }

  onAdd({ item }) {
    const nextTaskEl = item.nextElementSibling;
    const nextTaskId = nextTaskEl ? nextTaskEl.dataset.id : null

    patch(item.dataset.updateUrl, {
      body: {
        task: {
          list_id: this.listIdValue,
          position: { before: nextTaskId }
        }
      }
    })
  }

  onUpdate({ item }) {
    const nextTaskEl = item.nextElementSibling;
    const nextTaskId = nextTaskEl ? nextTaskEl.dataset.id : null

    patch(item.dataset.updateUrl, {
      body: {
        task: { position: { before: nextTaskId } }
      }
    })
  }
}
