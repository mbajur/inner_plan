pin "application"
pin "@hotwired/stimulus", to: "https://unpkg.com/@hotwired/stimulus/dist/stimulus.js"
pin "sortablejs", to: "https://cdn.jsdelivr.net/npm/sortablejs@1.15.4/+esm"
pin "@rails/request.js", to: "https://cdn.jsdelivr.net/npm/@rails/request.js@0.0.11/dist/requestjs.min.js"
pin "trix"
pin "@rails/actiontext", to: "actiontext.esm.js"

pin_all_from InnerPlan::Engine.root.join("app/javascript/controllers"), under: "controllers"
