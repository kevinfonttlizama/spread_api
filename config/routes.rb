Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  ##########
  get 'spreads/market/:market_id', to: 'spreads#market'
  get 'spreads/all_markets', to: 'spreads#all_markets'
  get 'alert_spread', to: 'spreads#alert_spread'
  post 'alert_spread', to: 'spreads#set_alert_spread'
  

end
