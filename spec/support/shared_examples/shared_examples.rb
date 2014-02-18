shared_examples "require_sign_in" do 
  it "redirects to the root_path" do
    end_user_session
    action
    response.should redirect_to root_path
  end
end