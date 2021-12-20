Rails.application.routes.draw do
  get '/example', to: 'example#index'

  namespace :deeper do
    get 'another_example', to: 'another_example#index'
  end

  get '/:post_slug', to: 'post#show_parent', as: 'show_parent'
  get '/:post_slug/:chapter_slug', to: 'post#show_chapter', as: 'show_chapter'
end
