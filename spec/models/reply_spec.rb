require 'spec_helper'
require 'shoulda-matchers'

describe Reply do 

  it { should belong_to(:review) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:response) }

end