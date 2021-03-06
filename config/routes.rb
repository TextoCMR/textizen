TxtyourcityRails::Application.routes.draw do
  resources :groups
  resources :group_users

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  devise_for :users, :controllers => { :registrations => "registrations", :invitations => "invitations" }, :path_names => { :sign_up => ENV['SIGN_UP_PATH'] || 'textizen4eva' }
  #devise_for :users, :path_names => { :sign_in => 'login', :sign_out => 'logout', :password => 'secret', :confirmation => 'verification', :unlock => 'unblock', :registration => 'register'}#, :controllers=>{:registrations=>"registrations"}
  #devise_for :admins
  #
  devise_scope :user do
    match 'invitations/resend/:id' => 'invitations#resend', :as => 'invitation_resend'
  end

  resources :polls do
    put :end, :on => :member # for polls/3/end?
    put :publish, :on => :member
    put :clear_responses, :on => :member # for polls/3/nuke
    collection do
      post "receive_message"
    end
  end

  resources :responses do
    collection do
      post "receive_message"
    end
  end

  match 'welcome' => 'static_pages#home'
  match 'about' => 'static_pages#about'
  match 'privacy' => 'static_pages#privacy'
  match 'getstarted' => 'static_pages#getstarted'

  # The priority is based upon order of creation:
  # first created -> highest priority.

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
  root :to => 'application#index' #'polls#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
