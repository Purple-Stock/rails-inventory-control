class SubdomainConstraint
  def self.matches?(request)
    subdomains = %w{ www admin}
    request.subdomain.present? && subdomains.exclude?(request.subdomain)
  end
end
 
Rails.application.routes.draw do
  constraints SubdomainConstraint do
    get '/info', to: 'companies#show'
    post 'employee/create', to: 'employees#create'
  end
  get 'companies/new'
  post 'companies/create'
  devise_for :users
  root to: 'companies#index'
end