# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

match 'redexporter/metrics' => 'redexporter#metrics', :via => :get

resources :redexporter_settings do
  collection do
    get :autocomplete_for_user
    post :save, to: 'redexporter_settings#save'
  end
end