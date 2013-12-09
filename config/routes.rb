Dejeuner::Application.routes.draw do
  resources :signup_emails, only: [:create]
  resources :charges
  resources :numbers
  resources :reviews
  resources :sms_contacts, only: [:destroy]
  devise_for :users

  # charges 
  get 'charges/new/:plan' => 'charges#new'

  # campaigns
  resources :campaigns
  get 'key_word' => 'campaigns#key_word'
  post 'key_word' => 'campaigns#update_key_word'
  get 'reward' => 'campaigns#reward'
  post 'reward' => 'campaigns#create_reward'

  # signupemail
  get 'signup_email/finish' => 'signup_emails#finish'

  # static pages
  root 'static_pages#landing'
  get 'pricing' => 'static_pages#pricing'
  get 'my_number' => 'static_pages#my_number'
  get 'my_contact' => 'static_pages#my_contact'
  get 'about' => 'static_pages#about'
  get 'contact' => 'static_pages#contact'

  # product
  get 'main' => 'product#main'
  get 'profile' => 'product#profile'
  get 'help' => 'product#help'
  get 'sms_credit_refill' => 'product#sms_credit_refill'
  get 'generate_sms' => 'product#generate_sms'
  post 'generate_sms' => 'product#create_sms'

  # marketing 
  get 'sms_response' => 'sms_response#sms_response'
  get 'market' => 'product#market'
  post 'market' => 'sms#send_message'
  get 'subscribers' => 'sms_contacts#index', as: :sms_contacts

  # checkins
  get "checkin" => 'check_ins#new'
  post "checkin" => "check_ins#create"
  get "loyalty" => "check_in_rewards#new"

  # loyalty rewards
  get "loyalty_rewards" => 'check_in_rewards#new', as: :new_check_in_reward
  post "loyalty" => "check_in_rewards#create"
  get "check_in_rewards/destroy"

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
