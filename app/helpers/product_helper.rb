module ProductHelper
  def get_months
    @months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    @months_with_index = []
    i = 1
    @months.each do |month| 
      @months_with_index << [month, i]
      i = i + 1
    end
  end
end
