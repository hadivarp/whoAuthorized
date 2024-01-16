Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html



  post '/sign_up', to: 'authentications#sign_up'
  post '/sign_in', to: 'authentications#sign_in'
  put '/sign_out' => 'authentications#sign_out'
  put '/forget_password' => 'authentications#forget_password'

end
