require 'spec_helper'
require 'shoulda-matchers'

describe CourseMaterial do
  it { should have_many(:bootcamps).through(:bootcamp_materials) }
  it {should validate_presence_of(:name) }
end