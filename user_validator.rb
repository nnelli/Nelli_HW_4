require 'CSV'

class UserValidator
  def initialize(filename)
    @filename = filename
    @data = CSV.read(@filename)
  end

  def get_numbers
    @data.flatten.select{|x| x.match(/\d{3}-\d{3}-\d{4}/)}
  end

end
