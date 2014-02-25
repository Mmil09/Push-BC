require 'spec_helper'

describe UsersController do
  describe "GET new" do 
    context "no user logged in" do 
      before { get :new }

      it "renders the new template" do
        expect(response).to render_template(:new)
      end

      it "assigns the user variable" do 
        expect(assigns(:user)).to be_present
      end
    end

    context "user logged in" do 
      it_behaves_like("require_log_out") do 
        let(:action) { get :new } 
      end
    end
  end

  describe "POST create" do 
    context "no user logged in and legit input" do 
      
      before { post :create, user: { username: "New User", password: "password", email: "user@email.com" } }
      
      it "redirects the user to the root_path" do 
        expect(response).to redirect_to(root_path)
      end

      it "sets the user variable" do 
        expect(assigns(:user)).to be_present
      end

      it "creates a new user" do 
        expect(User.count).to eq(1)
      end

      it "creates a new session" do 
        expect(session[:user]).to eq(User.first.id)
      end

      it "creates a flash message" do 
        expect(flash[:success]).to be_present
      end
    end

    context "no user logged in and incorrect input" do 
      before { post :create, user: { username: "", password: "password", email: "user@email.com" } }
      
      it "renders the new template" do 
        expect(response).to render_template(:new)
      end

      it "contains a flash error message" do 
        expect(flash[:error]).to be_present
      end

      it "sets the user variable" do
        expect(assigns(:user)).to be_present
      end

    end

    context "user logged in" do 
      it_behaves_like("require_log_out") do 
        let(:action) { get :create } 
      end
    end

  end

  describe "get edit" do
    
    context "user edits themself" do 
      let(:bob) { Fabricate(:user) } 
      before do
        current_user(bob)
        get :edit, id: bob.slug 
      end

      it "renders the edit template" do 
        expect(response).to render_template(:edit)
      end

      it "has user instance present" do 
        expect(assigns(:user)).to be_present
      end

      it "sets the user instance to the user" do 
        expect(assigns(:user)).to eq(bob)
      end

    end

    context "user tries to edit another user" do 
      let(:bob) { Fabricate(:user) } 
      let(:bill) { Fabricate(:user) }
      before do
        current_user(bob)
        get :edit, id: bill.slug 
      end

      it "redirects to the root path" do 
        expect(response).to redirect_to(root_path)
      end

      it "has a flash message present" do 
        expect(flash[:error]).to be_present
      end
    end

    context "user is an admin and edits another user" do 
      let(:bob) { Fabricate(:user, type: "Admin") } 
      let(:bill) { Fabricate(:user) }
      before do
        current_user(bob)
        get :edit, id: bill.slug 
      end

      it "renders the edit template" do 
        expect(response).to render_template(:edit)
      end

      it "has user instance present" do 
        expect(assigns(:user)).to be_present
      end

      it "sets the user instance to the user" do 
        expect(assigns(:user)).to eq(bill)
      end

    end

    context "user not logged in" do
      let(:bob) { Fabricate(:user) } 
      it_behaves_like("require_sign_in") do
        let(:action) { get :edit, id: bob.slug }
      end
    end


  end

  describe "post update" do 
    context "user updates themeself" do 
      let(:bob) { Fabricate(:user) }
      before do
        current_user(bob)
        put :update, user: { username: "NewName", email: "new@email.com", password: "newpassword"}, id: bob.slug
      end

      it "redirects to the user show path" do 
        expect(response).to redirect_to(user_path(assigns(:user)))
      end

      it "sets the user instance" do 
        expect(assigns(:user)).to be_present
      end

      it "updates the user correctly" do 
        expect(User.first.username).to eq("NewName")
      end

      it "has a flash message present" do
        expect(flash[:success]).to be_present
      end
    end

    context "user updates themeself with invalid input" do 
      let(:bob) { Fabricate(:user) }
      before do
        current_user(bob)
        put :update, user: { username: "NewName", email: "new@email.com", password: ""}, id: bob.slug
      end

      it "renders the edit template" do
        expect(response).to render_template(:edit)
      end

      it "contains a flash error message" do
        expect(flash[:error]).to be_present
      end

      it "does not update the user" do 
        bob.username.should_not eq("NewName")
      end

      it "contains an instance of user" do 
        expect(assigns(:user)).to be_present
      end

    end



    context "user tries to update another user" do 
      let(:bob) { Fabricate(:user) }
      let(:bill) { Fabricate(:user) }
      before do
        current_user(bob)
        put :update, user: { username: "NewName", email: "new@email.com", password: "newpassword"}, id: bill.slug
      end

      it "redirects to the root path" do 
        expect(response).to redirect_to(root_path)
      end

      it "contains a flash error" do 
        expect(flash[:error]).to be_present
      end

      it "sets an instance of user" do
        expect(assigns(:user)).to be_present
      end

      it "does not update the user" do 
        expect(assigns(:user).username).to eq(bill.username)
      end

    end

    context "user is an admin" do 
      let(:bob) { Fabricate(:user, type: "Admin") }
      let(:bill) { Fabricate(:user) }
      before do
        current_user(bob)
        put :update, user: { username: "NewName", email: "new@email.com", password: "newpassword"}, id: bill.slug
      end

      it "redirects to the user show path" do 
        expect(response).to redirect_to(user_path(assigns(:user)))
      end

      it "sets the user instance" do 
        expect(assigns(:user)).to be_present
      end

      it "updates the user correctly" do 
        expect(User.last.username).to eq("NewName")
      end

      it "has a flash message present" do
        expect(flash[:success]).to be_present
      end

    end

    context "user not logged in" do 
      let(:bob) { Fabricate(:user) } 
      it_behaves_like("require_sign_in") do
        let(:action) { put :update, id: bob.slug }
      end
    end
  end

  describe "GET show" do 
    let(:bob) { Fabricate(:user) }
    before { get :show, id: bob.slug }

    it "renders the show template" do 
      expect(response).to render_template(:show)
    end

    it "sets an instance of the user" do 
      expect(assigns(:user)).to be_present
    end

    it "sets the instance to the right user" do 
      expect(assigns(:user)).to eq(bob)
    end
  end

end