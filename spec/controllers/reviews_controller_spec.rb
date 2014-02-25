require 'spec_helper'

describe ReviewsController do
  describe "POST create" do 
    context "user has not reviewed bootcamp" do 
      let(:bob) { Fabricate(:user) }
      let(:bootcamp) { Fabricate(:bootcamp) }
      before do
        current_user(bob)
        post :create, review: { }
      end
    end
  end



end