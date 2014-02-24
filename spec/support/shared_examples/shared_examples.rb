shared_examples "require_sign_in" do 
  before do
    end_user_session
    action
  end
  
  it "redirects to the root_path" do
    end_user_session
    action
    response.should redirect_to root_path
  end

  it "displays a flash error" do 
    action
    flash[:error].should be_present
  end
end 

shared_examples "require_admin" do
  let(:user) { Fabricate(:user) }
    before do 
      current_user(user)
      action
    end  
  it "redirects to the root path" do 

    response.should redirect_to root_path
  end

  it "displays a flash error" do 
    flash[:error].should be_present
  end
end

shared_examples "require_log_out" do 
  before do 
    current_user
    action
  end

  it "redirects to the root path" do 
    expect(response).to redirect_to(root_path)
  end

  it "has a flash message present" do 
    expect(flash[:error]).to be_present
  end

end