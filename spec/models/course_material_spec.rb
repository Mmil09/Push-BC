require 'spec_helper'
require 'shoulda-matchers'

describe CourseMaterial do
  it { should have_many(:bootcamps).through(:bootcamp_materials) }
  it {should validate_presence_of(:name) }

  let(:course_material) { Fabricate(:course_material) }
  it "should create a slug after create" do 
    expect(course_material.slug).to be_present
  end
end