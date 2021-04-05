require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Validations' do
    before do 
      @user = User.new(
        first_name: 'Yamac',
        last_name: 'Ozdil',
        email: "yamac.ozdil@hey.com",
        password: "test123",
        password_confirmation: "test123"
      )
    end 

    describe "Validate Password" do
      it "should have be valid with a Password" do
        @user.password = "test123"
        @user.valid?
      end
      it "should have a Password" do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
    end

    describe "Validate Password_confirmation" do
      it "should have be valid with a Password_confirmation" do
        @user.password_confirmation = "test123"
        @user.valid?
      end
      it "should have a Password_confirmation" do
        @user.password_confirmation = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
      end
    end
  
    describe "Validate Password Match" do
      it "should be valid with a matching passwords" do
        @user.password = "test123"
        @user.password_confirmation = "test123"
        @user.valid?
      end
      it "should be invalid with non matching passwords" do
        @user.password = "test123"
        @user.password_confirmation = "test1234"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end
  
    describe "Validate Password Length" do
      it "should be valid for a Password Length from 6 to 20" do
        @user.password = "test123"
        @user.valid?
      end
      it "should be invalid for a Password Length of 4" do
        @user.password = "test"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it "should be invalid for a Password Length of 21" do
        @user.password = "test12345678912345678"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too long (maximum is 20 characters)")
      end
    end

    describe "Validate Email" do
      it "should have an Email" do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
    end

    describe "Validate Unique Email" do
      it "should have a unique Email" do
        @userTwo = User.new(
        first_name: 'Bob',
        last_name: 'Ross',
        email: "yamac.ozdil@hey.com",
        password: "test123",
        password_confirmation: "test123"
      )
        @userTwo.save
        @userTwo.valid?
        expect(@userTwo.errors.full_messages).to_not eq(nil)
      end
    end

    describe "Authenticate with Credentials" do
      before do
      @userCred = User.new(
        first_name: 'Yamac',
        last_name: 'Ozdil',
        email: "yamac.ozdil@hey.com",
        password: "test123",
        password_confirmation: "test123"
      )
      @userCred.save
      end
      it "should be valid for correct email & password" do
        result = User.authenticate_with_credentials('yamac.ozdil@hey.com', 'test123')
        expect(result).to_not eq(nil)
      end
      it "should not be valid for incorrect email" do
        result = User.authenticate_with_credentials('yyyyamac.ozdil@hey.com', 'test123')
        expect(result).to eq(nil)
      end
      it "should ignore spaces before and/or after their email address" do
        result = User.authenticate_with_credentials('    yamac.ozdil@hey.com  ', 'test123')
        expect(result).to_not eq(nil)
      end
      it "should ignore wrong case for their email" do
        result = User.authenticate_with_credentials('yaMAC.ozdil@hEy.COM', 'test123')
        expect(result).to_not eq(nil)
      end
    end
  
  end
end
