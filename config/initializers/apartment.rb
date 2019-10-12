require 'apartment/elevators/subdomain'
 
Apartment.configure do |config|
  config.excluded_models = %w{ User Company }
  config.tenant_names = lambda { Company.pluck :subdomain }
end
 
Rails.application.config.middleware.use Apartment::Elevators::Subdomain