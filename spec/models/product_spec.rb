require 'spec_helper'

RSpec.describe Product, type: :model do
	let(:product) { Product.new }

  it "is valid if save data" do
    expect(product).to be_valid
  end
end
