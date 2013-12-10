require 'spec_helper'

describe Campaign do
  before {@campaign = create(:campaign)}

  subject {@campaign}

  it {should respond_to(:campaign_type)}
  it {should respond_to(:description)}
  it {should respond_to(:user_id)}
  it {should be_valid}

  it "is invalid without a description" do 
    campaign = Campaign.new 
    campaign.should_not be_valid
  end

  describe "check length validations" do
    before {@campaign.description "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Alias, illo, modi, eligendi vitae veritatis voluptate ea asperiores tempora incidunt fugit odio quibusdam facilis accusantium numquam earum minus omnis quos voluptates. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Accusantium, tenetur, voluptates eligendi quod recusandae obcaecati sit eum aut quam totam odio natus sint cumque earum modi nemo minima illum consectetur. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sunt, nesciunt, autem optio distinctio quam rerum a nulla non magni modi labore quo vero debitis quas porro assumenda officia. Excepturi, nam."}
    it {should_not be_valid}
  end 

end
