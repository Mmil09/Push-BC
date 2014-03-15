require 'spec_helper'
require 'shoulda-matchers'

describe Review do
  it { should validate_presence_of(:rating) }
  it { should ensure_inclusion_of(:rating).in_range(1..5) }
  it { should validate_presence_of(:background) }
  it { should validate_presence_of(:instruction) }
  it { should validate_presence_of(:overall) }
  
  it { should belong_to(:user) }
  it { should belong_to(:bootcamp) }


  context "user has already created a review for bootcamp" do 
    let!(:bob) { Fabricate(:user) }
    let!(:bootcamp) { Fabricate(:bootcamp) }
    let!(:review1) { Fabricate(:review, bootcamp_id: bootcamp.id, user_id: bob.id) }
    it "does not save if user already reviewed bootcamp" do 
      review2 = Fabricate.build(:review, user_id: bob.id, bootcamp_id: bootcamp.id)
      expect(review2.save).to eq(false) 
    end
  end


  context "review background and instruction do not contain contain 150 words" do 
    let!(:bob) { Fabricate(:user) }
    let!(:bootcamp) { Fabricate(:bootcamp) }
    

    it "does not save the review" do 
      review = Fabricate.build(:review, user_id: bob.id, bootcamp_id: bootcamp.id, background: "Adfda kfdla ;fkdla f fda fda fda fdafda fdaf dafdafda fdafda fdafda fdafdaf fdafda fdafdafd a dfadfaf fdaklfdkla fdkla foiw iaf fafd klfjds fdafd afdklafj iofw fda fdalkjfow fdafda fifjdoa", instruction: "Adfda kfdla ;fkdla f fda fda fda fdafda fdaf dafdafda fdafda fdafda fdafdaf fdafda fdafdafd a dfadfaf fdaklfdkla fdkla foiw iaf fafd klfjds fdafd afdklafj iofw fda fdalkjfow fdafda fifjdoa")

      expect(review.save).to eq(false)
    end
  end

  context "review background and instruction do contain at least 150 words" do 
    let!(:bob) { Fabricate(:user) }
    let!(:bootcamp) { Fabricate(:bootcamp) }

    it "saves the review" do
      review = Fabricate.build(:review, user_id: bob.id, bootcamp_id: bootcamp.id)
      expect(review.save).to eq(true)
    end
  end



end