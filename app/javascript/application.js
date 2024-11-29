import { Application } from "@hotwired/stimulus"
import * as bootstrap from 'bootstrap'
import "trix"
import "@rails/actiontext"

import TasksTree from "./controllers/tasks_tree_controller"
import HwComboboxController from "controllers/hw_combobox_controller"

// Stimulus
window.Stimulus = Application.start()

Stimulus.register("tasks-tree", TasksTree)
Stimulus.register("hw-combobox", HwComboboxController)
