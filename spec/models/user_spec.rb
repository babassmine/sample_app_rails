require "rails_helper"

describe User do
	
	describe "Validation" do
		it { should have_valid(:name).when( "Example User") }
	end
end
