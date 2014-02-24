require 'spec_helper'

describe BcAdminsController do
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
        expect(assigns(:bc_admin)).to be_present
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
      let(:bootcamp) { Fabricate(:bootcamp) }
      let(:bootcamp2) { Fabricate(:bootcamp) }
      before do 
        current_user(bob)
        post :create, bc_admin: { username: "NewBCAdmin", password: "password", email: "bcadmin@email.com", bootcamp_ids: [bootcamp.id, bootcamp2.id]  } 
      end

      it "redirects to the root path" do 
        expect(response).to redirect_to(root_path)
      end

      it "contains a flash message" do 
        expect(flash[:success]).to be_present
      end

      it "assigns the bcadmin variable" do 
        expect(assigns(:bc_admin)).to be_present
      end

      it "creates a new bcadmin record" do
        expect(BCAdmin.count).to eq(1)
      end

      it "is associated with a bootcamp" do 
        expect(assigns(:bc_admin).bootcamps.count).to eq(2)
      end

      it "associates the correct bootcamps with the BCAdmin" do 
        expect(assigns(:bc_admin).bootcamps.first).to eq(bootcamp)
      end
      
    end

    context "user is admin, but enters invalid input" do 
      let(:bob) { Fabricate(:user, type: "Admin") }
      let(:bootcamp) { Fabricate(:bootcamp) }
      let(:bootcamp2) { Fabricate(:bootcamp) }
      before do 
        current_user(bob)
        post :create, bc_admin: { username: "", password: "password", email: "bcadmin@email.com", bootcamp_ids: [bootcamp.id, bootcamp2.id]  } 
      end

      it "renders the new template" do 
        expect(response).to render_template(:new)
      end

      it "contains a flash error" do 
        expect(flash[:error]).to be_present
      end

      it "assigns the bcadmin variable" do
        expect(assigns(:bc_admin)).to be_present
      end

      it "does not create a new bc_admin" do 
        expect(BCAdmin.count).to eq(0)
      end

    end  

    context "user not an admin" do 
      it_behaves_like("require_admin") do
        let(:action) { post :create, bc_admin: { username: "NewBCAdmin", password: "password", email: "bcadmin@email.com"  }}
      end
    end

    context "user not logged in" do 
      it_behaves_like("require_sign_in") do
        let(:action) { post :create, bc_admin: { username: "NewBCAdmin", password: "password", email: "bcadmin@email.com"  }}
      end
    end
  end
end


