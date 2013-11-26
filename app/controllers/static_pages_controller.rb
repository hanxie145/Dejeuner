class StaticPagesController < ApplicationController

  def landing 
    if current_user
      set_user()
    end
    @email = SignupEmail.new
  end 

  def pricing 
    if current_user
      set_user()
    end
  end

  def about 
    set_user()
  end
  
  def my_number 
  end 

  def my_contact
  end

end
