module GenerateSmsHelper

  # generate a sms for the customer to send out
  def generate_sms_from_args(businessName, industry, customerSegment, date, timeBegin, timeEnd, rewardType, reward)
    sms = businessName + ": "

    # change sms according to which customer segment we're targetting 
    if customerSegment === 'all customers'
    elsif customerSegment === 'last week' || customerSegment === 'two weeks' || customerSegment === 'last month'
      sms = sms + "We are missing you! "
    end

    # change their to your in reward text 
    reward = reward.downcase.gsub 'their', 'your'

    # change sms according to type of reward. Coupon or daily deal
    if rewardType === 'coupon'
      sms = sms + "Come on #{date} between #{timeBegin} and #{timeEnd} to get #{reward}!"
    elsif rewardType === 'deal'
      sms = sms + "Come on #{date} between #{timeBegin} and #{timeEnd} to get #{reward}!"
    end

    sms
  end

end
