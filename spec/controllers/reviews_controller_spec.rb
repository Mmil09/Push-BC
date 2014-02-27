require 'spec_helper'

describe ReviewsController do
  describe "POST create" do 
    context "user has not reviewed bootcamp" do 
      let(:bob) { Fabricate(:user) }
      let(:bootcamp) { Fabricate(:bootcamp) }
      before do
        current_user(bob)
        post :create, review: Fabricate.attributes_for(:review), bootcamp_id: bootcamp.slug
      end

      it "creates a review instance" do 
        expect(assigns(:review)).to be_present
      end

      it "redirects to the bootcamp being reviewed" do 
        expect(response).to redirect_to(bootcamp_path(bootcamp))
      end

      it "should have a flash message" do 
        expect(flash[:success]).to be_present
      end

      it "should have a new review" do 
        expect(Review.count).to eq(1)
      end

      it "should be associated with the user who made the review" do 
        expect(bob.reviews.count).to eq(1)
      end

      it "should be associated with the bootcamp that is being reviewed" do 
        expect(bootcamp.reviews.count).to eq(1)
      end
    end

    context "user has already reviewed bootcamp" do
      let(:bob) { Fabricate(:user) }
      let(:bootcamp) { Fabricate(:bootcamp) }
      let!(:review) { Fabricate(:review, user_id: bob.id, bootcamp_id: bootcamp.id) }
      
      before do
        current_user(bob)
        post :create, review: Fabricate.attributes_for(:review), bootcamp_id: bootcamp.slug
      end

      it "does not create a new review" do 
        expect(Review.count).to eq(1)
      end

      it "renders teh bootcamps/show template" do 
        expect(response).to render_template("bootcamps/show")
      end

      it "sets a review instance" do 
        expect(assigns(:review)).to be_present
      end

      it "should have a flash message" do 
        expect(flash[:error]).to be_present
      end

    end

    context "user is a bcadmin" do 
      let(:bob) { Fabricate(:user, type: "BCAdmin") }
      let(:bootcamp) { Fabricate(:bootcamp) }

       before do
        current_user(bob)
        post :create, review: Fabricate.attributes_for(:review), bootcamp_id: bootcamp.slug
      end

      it "does not create a new review" do 
        expect(Review.count).to eq(0)
      end

      it "does redirects to the bootcamp/show path" do 
        expect(response).to redirect_to(root_path)
      end

      it "has a flash error message" do 
        expect(flash[:error]).to be_present
      end

    end

    context "user not logged in" do 
      it_behaves_like "require_sign_in" do
        let(:bootcamp) { Fabricate(:bootcamp) } 
        let(:action) { post :create, review: Fabricate.attributes_for(:review), bootcamp_id: bootcamp.slug }
      end
    end
  end
end