Rails.application.routes.draw do

  mount ActivityEngine::Engine => "/activity_engine"
end
