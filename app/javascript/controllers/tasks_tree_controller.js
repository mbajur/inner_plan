import { Controller } from "@hotwired/stimulus";
import Sortable from "sortablejs"
import { patch } from "@rails/request.js"

// @todo split that into separate controllers for lists/groups/tasks ?
export default class extends Controller {
  static targets = ['list', 'group', 'groupsContainer', 'task', 'tasksContainer'];

  connect() {
    this.initialize()
  }

  disconnect() {
    this.destroy()
  }

  initialize() {
    this.groupsSortable = []
    this.tasksSortable = []
    this.listsSortable = Sortable.create(this.element, {
      handle: '.list-handle',
      group: 'list',
      onUpdate: this.onListUpdate.bind(this)
    })

    for (var i = 0; i < this.groupsContainerTargets.length; i++) {
      const group = this.groupsContainerTargets[i];

      this.groupsSortable.push(
        Sortable.create(group, {
          handle: '.group-handle',
          group: 'group',
          draggable: '[data-is-draggable="true"]',
          onUpdate: this.onGroupUpdate.bind(this),
          onAdd: this.onGroupAdd.bind(this),
        })
      )
    }

    for (var i = 0; i < this.tasksContainerTargets.length; i++) {
      const task = this.tasksContainerTargets[i];

      this.tasksSortable.push(
        Sortable.create(task, {
          handle: '.task-handle',
          group: 'task',
          onUpdate: this.onTaskUpdate.bind(this),
          onAdd: this.onTaskAdd.bind(this)
        })
      )
    }
  }

  destroy() {
    this.listsSortable.destroy();

    this.groupsSortable.forEach((item) => { item.destroy() });
    this.tasksSortable.forEach((item) => { item.destroy() });
  }

  onListUpdate({ item }) {
    const nextListEl = item.nextElementSibling;
    const nextListId = nextListEl ? nextListEl.dataset.id : null

    patch(item.dataset.updateUrl, {
      body: {
        list: { position: { before: nextListId } }
      }
    })
  }

  onTaskAdd({ item }) {
    const groupId = item.closest('[data-tasks-tree-target="group"]').dataset.id;
    const nextTaskEl = item.nextElementSibling;
    const nextTaskId = nextTaskEl ? nextTaskEl.dataset.id : null

    patch(item.dataset.updateUrl, {
      body: {
        task: {
          group_id: groupId,
          position: { before: nextTaskId }
        }
      }
    })
  }

  onTaskUpdate({ item }) {
    const nextTaskEl = item.nextElementSibling;
    const nextTaskId = nextTaskEl ? nextTaskEl.dataset.id : null

    patch(item.dataset.updateUrl, {
      body: {
        task: { position: { before: nextTaskId } }
      }
    })
  }

  onGroupAdd({ item }) {
    const listId = item.closest('[data-tasks-tree-target="list"]').dataset.id;
    const nextGroupEl = item.nextElementSibling;
    const nextGroupId = nextGroupEl ? nextGroupEl.dataset.id : null

    patch(item.dataset.updateUrl, {
      body: {
        group: {
          list_id: listId,
          position: { before: nextGroupId }
        }
      }
    })
  }

  onGroupUpdate({ item }) {
    const nextGroupEl = item.nextElementSibling;
    const nextGroupId = nextGroupEl ? nextGroupEl.dataset.id : null

    patch(item.dataset.updateUrl, {
      body: {
        group: { position: { before: nextGroupId } }
      }
    })
  }
}
