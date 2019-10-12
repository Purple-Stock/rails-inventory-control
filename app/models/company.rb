class Company < ApplicationRecord
  after_create :create_tenant
  
  def create_tenant
    Apartment::Tenant.create(subdomain)
  end

  def show
    @company = Company.find_by(subdomain: request.subdomain)
    @employees = Employee.all
    @empoyee = Employee.new
  end
end