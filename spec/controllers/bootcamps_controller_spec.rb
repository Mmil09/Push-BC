require 'spec_helper'

describe BootcampsController do
  describe "GET new" do
    context "user is an admin" do
      let(:bob) { Fabricate(:user, type: "Admin") }
      before do
        current_user(bob)
        get :new 
      end

      it "renders the new template" do 
        expect(response).to render_template(:new)
      end

      it "sets the bootcamp variable" do 
        expect(assigns(:bootcamp)).to be_present
      end
    end

    context "user is not logged in" do 
      it_behaves_like "require_sign_in" do 
        let(:action) { get :new }
      end
    end

    context "user is not an admin" do 
      it_behaves_like "require_admin" do 
        let(:action) { get :new }
      end
    end
  end

  describe "GET create" do 
    context "user is an admin" do 
      let(:bob) { Fabricate(:user, type: "Admin") }
      before do
        current_user(bob)
        post :create, bootcamp: { name: "New bootcamp", description: "description of bootcamp", cost: "1000" }
      end

      it "redirects to the show bootcamp path" do 
        expect(response).to redirect_to(bootcamp_path(assigns(:bootcamp).id))
      end

      it "creates a bootcamp variable" do
        expect(assigns(:bootcamp)).to be_present
      end

      it "creates a new bootcamp record" do 
        expect(Bootcamp.count).to eq(1)
      end

      it "creates a flash success message" do 
        expect(flash[:success]).to be_present
      end
    end
  end
end
