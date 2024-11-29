Rails.application.routes.draw do
  devise_for :users
  mount InnerPlan::Engine => "/inner_plan"
end
