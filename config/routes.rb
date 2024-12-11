InnerPlan::Engine.routes.draw do
  resources :lists, except: [:destroy] do
    patch :update_position, on: :member

    resources :tasks, shallow: true, except: [:destroy] do
      patch :update_position, on: :member
      post :complete, on: :member
      post :reopen, on: :member
    end

    resources :groups, shallow: true, except: [:destroy] do
      patch :update_position, on: :member
    end
  end

  resource :search, only: [:show]

  root to: 'lists#index'
end
