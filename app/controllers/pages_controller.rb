class PagesController < ApplicationController
  before_filter :authenticate, :only => [:restricted]
  
  def home
    @title = "Home"
  end

  def contact
  end
  
  def restricted
    @title = "Welcome!"
    @user = current_user
    flash[:success] = "Welcome #{@user.name}!"
  end

end
