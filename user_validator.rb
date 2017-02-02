require 'CSV'

class UserValidator
  def initialize(filename)
    @filename = filename
    @data = CSV.read(@filename)
  end

end
