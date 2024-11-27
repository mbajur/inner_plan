import { Application } from "@hotwired/stimulus"

import TasksTree from "./controllers/tasks_tree_controller"

window.Stimulus = Application.start()
Stimulus.register("tasks-tree", TasksTree)
