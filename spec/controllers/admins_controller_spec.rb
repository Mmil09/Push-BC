require 'spec_helper'

describe AdminsController do
  describe "GET new" do
    context "user is an admin" do
      let(:user) { Fabricate(:user, type: "Admin") }
      before { get :new }

      it "renders the new template" do 
        expect(response).to render_template(:new)
      end

      it "adds a new admin" do 
        expect(assigns(:admin)).to be_present
      end

    end

    context "user is not an admin" do 
      let(:user) { Fabricate(:user) }
      before { get :new }

      it "redirects to the root path" do 
        expect(response).to redirect_to(root_path)
      end

      it "contains a flash success message" do 
        expect(flash[:success]).to be_present
      end

    end
  end
end