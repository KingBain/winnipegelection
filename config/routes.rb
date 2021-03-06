Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  patch 'admin/news_sources/:id/toggle_is_local_source', to: 'admin/news_sources#toggle_is_local_source', as: 'admin_toggle_is_local_source'
  patch 'admin/news_articles/:id/change_moderation/:moderation', to: 'admin/news_articles#change_moderation', as: 'admin_change_moderation'

  get 'candidate/:name_slug', to: 'people#redirect_show'
  get 'trustee_candidate/:name_slug', to: 'people#redirect_show'
  get 'pages/:id/candidate/:name_slug', to: 'people#redirect_show', constraints: {id: /\d+/}

  get 'pages/:id/:slug', to: 'pages#show', as: :page, constraints: {id: /\d+/}
  get 'people/:id/:slug(/page/:page)', to: 'people#show', as: 'person', constraints: {id: /\d+/, page: /\d+/}

  get 'electoral_races/:id/:slug(/page/:page)', to: 'electoral_races#show', as: :electoral_race, constraints: {id: /\d+/, page: /\d+/}
  get 'electoral_races/council', to: 'electoral_races#council', as: :electoral_races_council
  get 'electoral_races/school_trustee', to: 'electoral_races#school_trustee', as: :electoral_races_school_trustee

  get 'image_maps/:id/:slug', to: 'image_maps#show', as: :image_map, constraints: {id: /\d+/}
  get 'issue_websites', to: 'issue_websites#index'
  get 'news_articles(/page/:page)', to: 'news_articles#index', as: :news_articles, constraints: {page: /\d+/}

  root to: 'home#index'

  #JSON API ROUTES
  get 'electoral_races/:id', to: 'electoral_races#show_json', format: true, constraints: {id: /\d+/, format: 'json'}
  get 'elections/:id', to: 'elections#show', format: true, constraints: { format: 'json' }
  patch 'candidacies/:id/update_questionnaire', to: 'candidacies#update_questionnaire', format:true, constraints: {id: /\d+/, format: 'json'}
end
