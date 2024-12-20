pin "application", to: "inner_plan/application.js", preload: true
pin "@hotwired/stimulus", to: "https://unpkg.com/@hotwired/stimulus/dist/stimulus.js"
pin "sortablejs", to: "https://cdn.jsdelivr.net/npm/sortablejs@1.15.4/+esm"
pin "@rails/request.js", to: "https://cdn.jsdelivr.net/npm/@rails/request.js@0.0.11/dist/requestjs.min.js"
pin "@popperjs/core", to: "https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/esm/popper.min.js"
pin "bootstrap", to: "https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.esm.min.js"

pin_all_from InnerPlan::Engine.root.join("app/javascript/inner_plan/controllers"), under: "controllers", to: "inner_plan/controllers"
