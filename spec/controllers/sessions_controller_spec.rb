require 'spec_helper'

describe SessionsController do 

  describe "GET new" do
    context "user not logged in" do 
      it "renders the new template" do
        get :new
        expect(response).to render_template(:new)
      end
    end

    context "user logged in" do 
      it_behaves_like("require_log_out") do 
        let(:action) { get :new } 
      end

    end

  end

  describe "post create" do 
    context "user enters valid data" do 
      let(:bob) { Fabricate(:user) }
      before { post :create, username: bob.username, password: bob.password } 

      
      it "redirects to the root path" do 
        expect(response).to redirect_to(root_path)
      end

      it "sets the user variable" do 
        expect(assigns(:user)).to be_present
      end

      it "sets the user variable to the correct user" do
        expect(assigns(:user)).to eq(bob)
      end

      it "creates a new user session" do 
        expect(session[:user]).to be_present
      end

      it "creates a new session with the correct user id" do
        expect(session[:user]).to eq(bob.id)
      end

      it "has a flash message" do 
        expect(flash[:success]).to be_present
      end

    end

    context "user has incorrect username" do 
      let(:bob) { Fabricate(:user) }
      before { post :create, username: bob.username, password: "sometypo" } 

      it "renders the new template" do 
        expect(response).to render_template(:new)
      end

      it "has a flash error message" do 
        expect(flash[:error]).to be_present
      end

      it "does not create a new session" do 
        expect(session[:user]).to be_nil
      end

    end

    context "user signed in" do 
      it_behaves_like("require_log_out") do 
        let(:action) { post :create } 
      end

    end
    
  end

  describe "get destroy" do 
    context "user logged in" do 
      before do 
        current_user
        get :destroy
      end

      it "redirects to the root path" do 
        expect(response).to redirect_to(root_path)
      end

      it "contains a flash success message" do 
        expect(flash[:success]).to be_present
      end

      it "sets session[:user] to nil" do 
        expect(session[:user]).to be_nil
      end
    end

    context "user not logged in" do 
      it_behaves_like("require_sign_in") do 
        let(:action) { delete :destroy }
      end
    end

  end
  
end

