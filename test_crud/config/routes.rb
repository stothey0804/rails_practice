# -*- encoding : utf-8 -*-
#require 'sidekiq/web'
#mount Sidekiq::Web, at: '/sidekiq'

Gshop::Application.routes.draw do

    ############################################################
  # for admin
  ############################################################
  constraints(Subdomain) do

    match 'admin', :to => redirect('/admin/reports/dashboard')

    namespace :admin do

      scope '/product' do
        # test
        resources :test_brands do
          collection do
            get :code_list
          end
        end
      end


      
  root :to => 'main#index'
  get '/clear', :to => 'main#index_clear', :as => 'root_clear'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
