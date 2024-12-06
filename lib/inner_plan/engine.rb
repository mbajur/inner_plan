module InnerPlan
  class Engine < ::Rails::Engine
    isolate_namespace InnerPlan

    initializer "inner_plan.importmap", before: "importmap" do |app|
      # https://github.com/rails/importmap-rails#composing-import-maps
      # app.config.importmap.paths << root.join("config/importmap.rb")
      InnerPlan.importmap.draw(root.join("config/importmap.rb"))

      # https://github.com/rails/importmap-rails#sweeping-the-cache-in-development-and-test
      app.config.importmap.cache_sweepers << root.join("app/javascript")
    end

    initializer "inner_plan.assets" do |app|
      # my_engine/app/javascript needs to be in the asset path
      app.config.assets.paths << root.join("app/javascript")

      # manifest has to be precompiled
      app.config.assets.precompile += %w[inner_plan/manifest.js]
    end
  end
end
