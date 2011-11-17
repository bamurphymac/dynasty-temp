Dynasty::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :users

  scope :league, :module => 'league', :as => 'league', :constraints => SubdomainConstraint do
    resource :draft
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  resources :person_scores, :events, :dynasty_dollars, :positions, :trades,
            :user_teams, :user_team_person, :users, :person_phases, :display_names,
            :stats, :fix, :draftable_players, :picks, :salaries,
            :persons, :drafts, :leagues, :admin_dashboard

  resources :teams do
    resources :display_name, :person_phases
  end

  resources :persons do
    resources :display_name
  end

  resources :drafts do
    member do
      get 'push_available_players'
    end
    member do
      get 'push_draft_status'
    end
    member do
      get 'roster'
    end
    member do
      get 'auto_pick'
    end
    member do
      get 'draft_auto_pick'
    end
    member do
      get 'users'
    end
    member do
      get 'available_players'
    end
    member do
      get 'status'
    end
  end


  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "admin/dashboard#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
