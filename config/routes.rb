# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get 'home/pokedex' => 'home#pokedex'
      get 'home/counters/:id(/:legendary)' => 'home#counters'
      post 'home/team_counters' => 'home#team_counters'
    end
  end
end
