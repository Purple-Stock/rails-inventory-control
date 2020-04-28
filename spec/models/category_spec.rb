require 'spec_helper'

RSpec.describe Category, type: :model do
	let(:category) { Category.new }

  it "is valid if save data" do
    expect(category).to be_nil
  end
end
