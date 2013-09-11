class StaticPagesController < ApplicationController

  def landing 
    @email = SignupEmail.new
  end 

  def pricing 
  end
  
  def my_number 
  end 

  def my_contact
  end

end
