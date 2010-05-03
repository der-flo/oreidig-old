ActionController::Routing::Routes.draw do |map|
  map.resources :links, :only => [:index, :show, :create, :update, :destroy]
  map.resources :tags, :only => [:index, :show]
  map.resource :search, :only => :create

  map.root :controller => 'home', :action => 'show'
end
