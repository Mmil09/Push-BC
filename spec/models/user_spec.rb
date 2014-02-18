require 'spec_helper'
require 'shoulda-matchers'

describe User do

	it { should validate_presence_of(:username) }
	it { should validate_presence_of(:email) }
	it { should validate_presence_of(:password) }
	it { should validate_uniqueness_of(:username) } 
  it { should validate_uniqueness_of(:email) }

end

