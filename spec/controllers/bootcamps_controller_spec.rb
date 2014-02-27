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
        expect(response).to redirect_to(bootcamp_path(assigns(:bootcamp)))
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

    context "user is not logged in" do 
      it_behaves_like "require_sign_in" do 
        let(:action) { get :new }
      end
    end

    context "user not an admin" do 
      it_behaves_like "require_admin" do 
        let(:action) { post :create, bootcamp: { name: "New bootcamp", description: "description of bootcamp", cost: "1000" } }
      end
    end
  end

  describe "GET show" do 
    context "bootcamp exists" do 
      let(:bootcamp) { Fabricate(:bootcamp) }
      before { get :show, id: bootcamp.slug }

      it "renders the show template" do 
        expect(response).to render_template(:show)
      end

      it "contains a bootcamp instance" do 
        expect(assigns(:bootcamp)).to be_present
      end

      it "creates a bootcamp instance that is based on the id passed in" do 
        expect(assigns(:bootcamp)).to eq(Bootcamp.first)
      end

    end
  end

  describe "GET edit" do 
    context "user is an admin" do 
      let(:bob) { Fabricate(:user, type: "Admin") }
      let(:bootcamp) { Fabricate(:bootcamp) }
      before do 
        current_user(bob)
        get :edit, id: bootcamp.slug 
      end

      it "renders the edit view" do 
        expect(response).to render_template(:edit)
      end
      it "sets a bootcamp instance" do 
        expect(assigns(:bootcamp)).to be_present
      end
      it "sets the bootcamp instance to the right record" do 
        expect(assigns(:bootcamp)).to eq(bootcamp)
      end
    end

    context "user is a bootcamp administrator for bootcamp" do 
      let(:bootcamp) { Fabricate(:bootcamp) }
      let(:bob) { Fabricate(:user, type: "BCAdmin", bootcamp_ids: bootcamp.id) }
      
      before do 
        current_user(bob)
        get :edit, id: bootcamp.slug 
      end

      it "renders the edit view" do 
        expect(response).to render_template(:edit)
      end

      it "sets a bootcamp instance" do 
        expect(assigns(:bootcamp)).to be_present
      end

      it "sets the bootcamp instance to the right record" do 
        expect(assigns(:bootcamp)).to eq(bootcamp)
      end

    end

    context "user bootcamp admin but not for given bootcamp" do 
      let(:bootcamp) { Fabricate(:bootcamp) }
      let(:bob) { Fabricate(:user, type: "BCAdmin") }
      
      before do 
        current_user(bob)
        get :edit, id: bootcamp.slug 
      end

      it "redirects to the root path" do 
        expect(response).to redirect_to(root_path)
      end

      it "expect flash[:error] to be present" do 
        expect(flash[:error]).to be_present
      end
    end

    context "user not BCAdmin" do 
      let(:bootcamp) { Fabricate(:bootcamp) }
      let(:bob) { Fabricate(:user) }
      
      before do 
        current_user(bob)
        get :edit, id: bootcamp.slug 
      end

      it "redirects to the root path" do 
        expect(response).to redirect_to(root_path)
      end

      it "expect flash[:error] to be present" do 
        expect(flash[:error]).to be_present
      end
    end

    context "user not logged in" do 
      let(:bootcamp) { Fabricate(:bootcamp) }
      
      it_behaves_like "require_sign_in" do 
        let(:action) { get :edit, id: bootcamp.slug }
      end

    end


  end

  describe "PUT update" do 
    context "BCAdmin is associated with bootcamp" do
      let(:bootcamp) { Fabricate(:bootcamp) }
      let(:bob) { Fabricate(:user, type: "BCAdmin", bootcamp_ids: bootcamp.id) }
      before do
        current_user(bob)
        put :update, bootcamp: { name: "New Bootcamp", description: "new description" }, id: bootcamp.slug
      end

      it "redirects the user to the bootcamp show path" do 
        expect(response).to redirect_to(bootcamp_path(assigns(:bootcamp)))
      end

      it "displays a flash success message" do 
        expect(flash[:success]).to be_present
      end

      it "sets the bootcamp instance" do 
        expect(assigns(:bootcamp)).to be_present
      end

      it "changes the parameters on bootcamp" do
        expect(Bootcamp.first.name).to eq("New Bootcamp")
      end
    end

    context "BCAdmin is not associated with bootcamp" do 
      let(:bootcamp) { Fabricate(:bootcamp) }
      let(:bob) { Fabricate(:user, type: "BCAdmin") }
      before do
        current_user(bob)
        put :update, bootcamp: { name: "New Bootcamp", description: "new description" }, id: bootcamp.slug
      end

      it "redirects to the root path" do 
        expect(response).to redirect_to(root_path)
      end

      it "contains a flash error message" do 
        expect(flash[:error]).to be_present
      end

      it "sets an instance of bootcamp" do 
        expect(assigns(:bootcamp)).to be_present
      end

      it "does not update the record" do 
        bootcamp.name.should_not eq("New Bootcamp")
      end
    end

    context "user is an admin" do 
      let(:bootcamp) { Fabricate(:bootcamp) }
      let(:bob) { Fabricate(:user, type: "Admin") }
      before do
        current_user(bob)
        put :update, bootcamp: { name: "New Bootcamp", description: "new description" }, id: bootcamp.slug
      end

      it "redirects the user to the bootcamp show path" do 
        expect(response).to redirect_to(bootcamp_path(assigns(:bootcamp)))
      end

      it "displays a flash success message" do 
        expect(flash[:success]).to be_present
      end

      it "sets the bootcamp instance" do 
        expect(assigns(:bootcamp)).to be_present
      end

      it "changes the parameters on bootcamp" do
        expect(Bootcamp.first.name).to eq("New Bootcamp")
      end
    end

    context "user not an admin" do 
      it_behaves_like "require_admin" do
        let(:bootcamp) { Fabricate(:bootcamp) } 
        let(:action) { put :update, bootcamp: { name: "New bootcamp", description: "description of bootcamp" }, id: bootcamp.slug  }
      end
    end

    context "user not logged in" do 
      it_behaves_like "require_sign_in" do
        let(:bootcamp) { Fabricate(:bootcamp) } 
        let(:action) { put :update, bootcamp: { name: "New bootcamp", description: "description of bootcamp" }, id: bootcamp.slug  }
      end
    end
  end
end
