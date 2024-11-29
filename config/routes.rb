InnerPlan::Engine.routes.draw do
  resources :lists, except: [:destroy] do
    patch :update_position, on: :member

    resources :groups, shallow: true, except: [:destroy] do
      patch :update_position, on: :member

      resources :tasks, shallow: true, except: [:destroy] do
        patch :update_position, on: :member
        post :complete, on: :member
        post :reopen, on: :member
      end
    end
  end

  resources :users, only: [:index] do
    post :combobox_chips, on: :collection
  end

  root to: 'lists#index'
end
