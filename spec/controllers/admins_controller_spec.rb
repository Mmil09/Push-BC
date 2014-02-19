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
      it_behaves_like "require_admin" do
        let(:action) { get :new }
      end

    end

    context "user is not logged in" do 
      it_behaves_like "require_sign_in" do
        let(:action) { get :new }
      end
    end
  end

  describe "POST create" do 
    context "user is an admin and input is valid" do 
      let(:bob) { Fabricate(:user, type: "Admin") }
      before do 
        current_user(bob)
        post :create, admin: { username: "NewAdmin", password: "password", email: "admin@email.com"  } 
      end
      it "redirects to the root path" do 
        expect(response).to redirect_to(root_path)
      end

      it "contains a flash message" do 
        expect(flash[:success]).to be_present
      end

      it "assigns the admin variable" do 
        expect(assigns(:admin)).to be_present
      end

      it "creates a new admin record" do 
        expect(Admin.count).to eq(2)
      end
    end 

    context "user is admin with invalid input" do 
      let(:bob) { Fabricate(:user, type: "Admin") }
      before do 
        current_user(bob)
        post :create, admin: { username: "NewAdmin", password: "password", email: ""  } 
      end

      it "renders the new template" do 
        expect(response).to render_template(:new)
      end

      it "contains a flash error message" do 
        expect(flash[:error]).to be_present
      end

      it "assigns the admin variable" do 
        expect(assigns(:admin)).to be_present
      end

      it "does not create a new admin" do 
        expect(Admin.count).to be_present
      end
    end

    context "user not an admin" do 
      it_behaves_like("require_admin") do
        let(:action) { post :create, admin: { username: "NewAdmin", password: "password", email: "admin@email.com"  }}
      end
    end

    context "user not logged in" do 
      it_behaves_like("require_sign_in") do
        let(:action) { post :create, admin: { username: "NewAdmin", password: "password", email: "admin@email.com"  }}
      end
    end
  end
end