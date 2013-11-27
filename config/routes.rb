Dejeuner::Application.routes.draw do

  resources :signup_emails, only: [:create]

  resources :numbers
  resources :reviews
  devise_for :users

  # campaigns
  resources :campaigns
  get 'key_word' => 'campaigns#key_word'
  post 'key_word' => 'campaigns#update_key_word'

  # signupemail
  get 'signup_email/finish' => 'signup_emails#finish'

  # static pages
  root 'static_pages#landing'
  get 'pricing' => 'static_pages#pricing'
  get 'my_number' => 'static_pages#my_number'
  get 'my_contact' => 'static_pages#my_contact'
  get 'about' => 'static_pages#about'

  # product
  get 'main' => 'product#main'
  get 'sms_response' => 'twilio#sms_response'
  get 'market' => 'product#market'
  post 'market' => 'sms#send_message'
  get 'profile' => 'product#profile'
  get 'help' => 'product#help'

  # demo
  namespace :demo do 
    get 'profile'
    get 'main'
    get 'campaign'
    get 'market'
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
