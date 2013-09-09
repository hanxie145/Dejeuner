require 'spec_helper'

describe Campaign do
  before {@campaign = create(:campaign)}

  subject {@campaign}

  it {should respond_to(:campaign_type)}
  it {should respond_to(:user_id)}
  it {should be_valid}

  describe "check length validations" do
    before {@campaign.description "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Alias, illo, modi, eligendi vitae veritatis voluptate ea asperiores tempora incidunt fugit odio quibusdam facilis accusantium numquam earum minus omnis quos voluptates."}
    it {should_not be_valid}
  end 

end
