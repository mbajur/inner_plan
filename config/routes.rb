InnerPlan::Engine.routes.draw do
  resources :lists do
    patch :update_position, on: :member

    resources :groups, shallow: true do
      patch :update_position, on: :member

      resources :tasks, shallow: true do
        patch :update_position, on: :member
        post :complete, on: :member
        post :reopen, on: :member
      end
    end
  end

  root to: 'lists#index'
end
