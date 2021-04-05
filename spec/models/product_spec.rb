require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before do 
      @category = Category.new(name: "RSpec Test")
      @product = Product.new(
        name: "Anything",
        price_cents: 100,
        quantity: 1,
        category: @category
      )
    end

    describe "Validate Name" do
      it 'should be valid with a Name' do
        @product.name = 'Anything'
        @product.valid?
      end
      it 'should have a Name' do
        @product.name = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("Name can't be blank")
      end
    end

    describe "Validate Quantity" do
      it 'should be valid with a Quantity' do
        @product.quantity = 1
        @product.valid?
      end
      it 'should have a Quantity' do
        @product.quantity = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("Quantity can't be blank")
      end
    end

    describe "Validate Category" do
      it 'should be valid with a Category' do
        @product.category = @category
        @product.valid?
      end
      it 'should have a Category' do
        @product.category = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("Category can't be blank")
      end
    end
  end
end
