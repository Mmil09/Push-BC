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

end