require 'spec_helper'
require 'shoulda-matchers'

describe Bootcamp do

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_numericality_of(:length).only_integer }
  it { should validate_numericality_of(:deposit).only_integer }
  it { should validate_numericality_of(:cost) }
  it { should have_many(:users).through(:user_bootcamps) }
  it { should have_many(:course_materials).through(:bootcamp_materials) }

end