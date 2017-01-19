Rails.application.routes.draw do
  root to: redirect('/make_guess')

  get '/make_guess', to: 'guess#index', as: :make_guess
  post '/make_guess', to: 'guess#make_guess'

  get '/confirm_guess/:guess_id', to: 'guess#confirm_guess', as: :confirm_guess
  post '/confirm_guess/:guess_id', to: 'guess#record_truth'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
