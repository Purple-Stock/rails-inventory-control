class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.text :description
      t.string :subdomain
      t.string :cnpj
      t.string :cpf

      t.timestamps
    end
  end
end
