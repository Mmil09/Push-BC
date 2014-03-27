require 'spec_helper'

describe RepliesController do
  describe "POST create" do 
    context "user is bc_admin of bootcamp and valid data is entered" do 
      let(:joe) { Fabricate(:user) }
      let(:bootcamp) { Fabricate(:bootcamp) }
      let(:bob) { Fabricate(:user, type: "BCAdmin", bootcamp_ids: bootcamp.id) }
      let!(:review) {Fabricate(:review, bootcamp_id: bootcamp.id, user_id: joe.id)}
      before do 
        current_user(bob)
        request.env["HTTP_REFERER"] = "where_i_came_from"
        post :create, Fabricate.attributes_for(:reply, review_id: review.id)
      end
      
      it "redirects to where I came from" do 
        expect(response).to redirect_to("where_i_came_from")
      end
      it "contains a flash success message" do 
        expect(flash[:success]).to be_present
      end
      it "sets an instance of response" do 
        expect(assigns(:reply)).to be_present
      end
      it "creates a new response" do
        expect(Reply.count).to eq(1)
      end
      it "correctly associates the response with the review" do 
        expect(Reply.first.review_id).to eq(review.id)
      end
    end

    context "user is bc_admin but invalid data is entered." do
      let(:joe) { Fabricate(:user) }
      let(:bootcamp) { Fabricate(:bootcamp) }
      let(:bob) { Fabricate(:user, type: "BCAdmin", bootcamp_ids: bootcamp.id) }
      let!(:review) {Fabricate(:review, bootcamp_id: bootcamp.id, user_id: joe.id)}
      before do 
        current_user(bob)
        request.env["HTTP_REFERER"] = "where_i_came_from"
        post :create, Fabricate.attributes_for(:reply, response: "", review_id: review.id)
      end

      it "creates an instance of reply" do 
        expect(assigns(:reply)).to be_present
      end
      it "has a flash error" do 
        expect(flash[:error]).to be_present
      end
      it "redirects to where_i_came_from" do
        expect(response).to redirect_to("where_i_came_from")
      end
      it "does not save the reply" do 
        expect(Reply.count).to eq(0)
      end
    end

    context "user is a bc_admin but not of this bootcamp" do 
      let(:joe) { Fabricate(:user) }
      let(:bootcamp) { Fabricate(:bootcamp) }
      let(:bob) { Fabricate(:user, type: "BCAdmin") }
      let!(:review) {Fabricate(:review, bootcamp_id: bootcamp.id, user_id: joe.id)}
      before do 
        current_user(bob)
        post :create, Fabricate.attributes_for(:reply, review_id: review.id)
      end

      it "redirects to where_i_came_from" do
        expect(response).to redirect_to(root_path)
      end 
      it "sets a flash message" do 
        expect(flash[:error]).to be_present
      end

      it "does not create a new reply" do 
        expect(Reply.count).to eq(0)
      end

    end

    context "user is not logged in" do 
      it_behaves_like "require_sign_in" do
        let(:bootcamp) { Fabricate(:bootcamp) } 
        let(:bob) {Fabricate(:user) }
        let(:review) { Fabricate(:review, bootcamp_id: bootcamp.id, user_id: bob.id) }
        let(:action) { post :create, Fabricate.attributes_for(:reply, review_id: review.id) }
      end
    end
  end
end