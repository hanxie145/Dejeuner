require 'spec_helper'

describe Campaign do
  before {@campaign = create(:campaign)}

  subject {@campaign}

  it {should respond_to(:campaign_type)}
  it {should respond_to(:user_id)}
  it {should be_valid}

end
