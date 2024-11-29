import { Application } from "@hotwired/stimulus"
import "trix"
import "@rails/actiontext"

import TasksTree from "./controllers/tasks_tree_controller"
import HwComboboxController from "controllers/hw_combobox_controller"

window.Stimulus = Application.start()

Stimulus.register("tasks-tree", TasksTree)
Stimulus.register("hw-combobox", HwComboboxController)
