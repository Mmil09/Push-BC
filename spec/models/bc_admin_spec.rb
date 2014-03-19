require 'spec_helper'
require 'shoulda-matchers'

describe BCAdmin do
  it { should have_many(:replies) }

end 