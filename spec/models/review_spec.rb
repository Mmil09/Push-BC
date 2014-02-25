require 'spec_helper'
require 'shoulda-matchers'

describe Review do
  it { should validate_presence_of(:rating) }
  it { should ensure_inclusion_of(:rating).in_range(1..5) }
  it { should validate_presence_of(:background) }
  it { should validate_presence_of(:instruction) }
  it { should validate_presence_of(:overall) }
  it { should ensure_length_of(:background).is_at_least(150) }
  it { should ensure_length_of(:instruction).is_at_least(150) }
  it { should ensure_length_of(:overall).is_at_least(300) }
  it { should belong_to(:user) }
  it { should belong_to(:bootcamp) }

end