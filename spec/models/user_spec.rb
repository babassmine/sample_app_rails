# require "rails_helper"

# describe User do

# 	describe "Validation" do
# 		it { should have_valid(:name).when( "Example User") }
# 		it { should have_valid(:email).when( 'bassco10@gmail.com') }
# 	end
# end

require 'rails_helper'

describe User do
	before do
		@user = User.new({:name => "Example User",
											:email => "example@mail.com",
											:password => "foobar",
											:password_confirmation => "foobar"})
	end
	describe 'validation' do
		it { should have_valid(:name ).when("Example User")  }
		it { should have_valid(:email).when("example@gmail.com") }
		it { should_not have_valid(:name).when(" ")} #empty name
		it { should_not have_valid(:name).when("a"*51)} #exceeds max
		it { should_not have_valid(:email).when((1..300).to_s) } #exceeds max
		it { should_not have_valid(:email).when(" "*6)} #empty address
		it { should_not have_valid(:email).when("a"*5)} #minimum length
		it { should_not have_valid(:email).when("example@comcast..com")}
		it { should_not have_valid(:email).when(%w[user@example,com user_at_foo.org user.name@example.
		                        foo@bar_baz.com foo@bar+baz.com])}

		#-----------Validates the uniqueness of a column----------------#
		it { should_not validate_uniqueness_of(:name) }
		it { should validate_uniqueness_of(:email) }
		#---------------------------------------------------------------#

		#-----------Email should be saved as lowercase------------------#
		it "email should be stored in lowercase" do
			mixed_case_email = "Foo@ExAMPle.CoM"
			@user.email = mixed_case_email
			@user.save
			@user.reload.email.should == mixed_case_email.downcase
		end
		#---------------------------------------------------------------#

		it "authenticated? should return false for a user with nil digest" do
			should_not @user.authenticated?('')
		end


		it{ should have_valid(:email).when("user@example.com")}
		it{ should have_valid(:email).when("USER@foo.COM")}
		it{ should have_valid(:email).when("A_US-ER@foo.bar.org")}
		it{ should have_valid(:email).when("first.last@foo.jp")}
		it{ should have_valid(:email).when("alice+bob@baz.cn")}

	end


end
