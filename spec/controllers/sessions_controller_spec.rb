require 'spec_helper'

describe SessionsController do
  integrate_views
  
  describe "GET 'new'" do
    it "should be successful" do
      get :new
      response.should be_success
    end
  
    it "should have the right title" do
      get :new
      response.should have_tag("title", /sign in/i)
    end
  
  end
  
  
  
end
