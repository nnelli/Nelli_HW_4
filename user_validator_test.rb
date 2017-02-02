require 'minitest/autorun'
require 'minitest/pride'
require './user_validator.rb'

class UserValidatorTest < Minitest::Test

  def test_initialize
    assert UserValidator.new('homework.csv')
  end

end
