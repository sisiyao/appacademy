Rails.application.routes.draw do

  resources :users, only: [:create, :new, :show]

  resource :session, only: [:create, :new, :destroy]

  resources :subs, except: [:destroy] do
    resources :posts, only: [:new]
  end

  resources :posts, except: [:index, :new] do
    resources :comments, only: :new
    resources :votes, only: :create
  end

  resources :comments, only: [:create, :delete, :show]

  post 'posts/:post_id/upvote', to: "votes#upvote", as: 'post_upvote'
  post 'posts/:post_id/downvote', to: "votes#downvote", as: 'post_downvote'
  post 'comments/:comment_id/upvote', to: "votes#upvote", as: 'comment_upvote'
  post 'comments/:comment_id/downvote', to: "votes#downvote", as: 'comment_downvote'

end
