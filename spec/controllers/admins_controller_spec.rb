require 'spec_helper'

describe AdminsController do
  describe "GET new" do
    context "user is an admin" do
      let(:user) { Fabricate(:user, type: "Admin") }
      before do
        current_user(user)
        get :new 
      end

      it "renders the new template" do 
        expect(response).to render_template(:new)
      end

      it "adds a new admin" do 
        expect(assigns(:admin)).to be_present
      end

    end

    context "user is not an admin" do 
      let(:user) { Fabricate(:user) }
      before do 
        current_user(user)
        get :new 
      end  

      it "redirects to the root path" do 
        expect(response).to redirect_to(root_path)
      end

      it "displays a flash error message" do 
        expect(flash[:error]).to be_present
      end
    end

    context "user is not logged in" do 
      it_behaves_like "require_sign_in" do
        let(:action) { get :new }
      end
    end
  end
end