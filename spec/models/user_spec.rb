require 'spec_helper'
require 'shoulda-matchers'

describe User do

	it { should validate_presence_of(:username) }
	it { should validate_presence_of(:email) }
	it { should validate_presence_of(:password) }
	it { should validate_uniqueness_of(:username) } 
  it { should validate_uniqueness_of(:email) }
  it { should have_many(:bootcamps).through(:user_bootcamps) }
  it { should validate_confirmation_of(:password) }

  let(:user) { Fabricate(:user) }

  it "creates a slug after create" do 
    expect(user.slug).to be_present
  end


end

