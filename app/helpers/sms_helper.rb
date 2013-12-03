module SmsHelper

  # method to make a sample get request to sms_response and see what happens 
  def test_response
    uri = URI("http://localhost:3000/sms_response?From=16049108862&To=17787260394&Text='Test message'")
    Net::HTTP.get(uri)
  end
end
