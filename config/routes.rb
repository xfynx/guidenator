Rails.application.routes.draw do
  get '/example', to: 'example#index'

  namespace :deeper do
    get 'another_example', to: 'another_example#index'
  end

  get '/:post_slug', to: 'post#show_parent'
end
