import { Application } from "@hotwired/stimulus"
import * as bootstrap from 'bootstrap'

import ListsController from "./controllers/inner_plan/lists_controller"
import GroupsController from "./controllers/inner_plan/groups_controller"
import TasksController from "./controllers/inner_plan/tasks_controller"
import TaskInlineFormController from "./controllers/inner_plan/task_inline_form_controller"
import HwComboboxController from "controllers/hw_combobox_controller"

// Stimulus
window.Stimulus = Application.start()

Stimulus.register("lists", ListsController)
Stimulus.register("groups", GroupsController)
Stimulus.register("tasks", TasksController)
Stimulus.register("task-inline-form", TaskInlineFormController)
Stimulus.register("hw-combobox", HwComboboxController)
