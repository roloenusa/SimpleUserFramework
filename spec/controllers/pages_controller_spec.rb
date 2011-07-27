require 'spec_helper'

describe PagesController do
  render_views
  
  before(:each) do
    @base_title = "WoW Wishlist"
  end

  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'home'
      response.should have_selector("title", :content => "#{@base_title} | Home")
    end
  end
  
  describe "GET 'restricted'" do
      
    describe "when not signed in" do
      
      it "should deny access" do
        get 'restricted'
        response.should redirect_to(signin_path)
      end
    end
    
    describe "when signed in" do
      
      before(:each) do
        @user = Factory(:user)
        test_sign_in @user
      end
      
      it "should allow access" do
        get :restricted
        response.should be_success
      end
      
      it "should have the right title" do
        get :restricted
        response.should have_selector("title", :content => "Welcome!")
      end
      
      it "should have flash with welcome message" do
        get :restricted
        flash[:success].should =~ /welcome/i
      end
      
      it "should display the correct user name" do
        get :restricted
        response.should have_selector("h1", :content => @user.name)
      end
    end
  end

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end
  end

end
