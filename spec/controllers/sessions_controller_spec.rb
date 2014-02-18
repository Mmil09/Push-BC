require 'spec_helper'

describe SessionsController do 

  describe "GET new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
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
      before { post :create, username: bob.password, password: "sometypo" } 

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

    
  end

  describe "get destroy" do 
    before do 
      current_user
      delete :destroy
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
  
end

