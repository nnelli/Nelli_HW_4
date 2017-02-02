require 'minitest/autorun'
require 'minitest/pride'
require './user_validator.rb'

class UserValidatorTest < Minitest::Test

  def test_initialize
    assert UserValidator.new('homework.csv')
  end

  def test_joined
    user = UserValidator.new('homework.csv')
    bad_joined_dates = user.check_joined
    assert bad_joined_dates == [1,4,6]
  end

  def test_email
    user = UserValidator.new('homework.csv')
    bad_emails = user.check_email
    assert bad_emails == [1,2]
  end

  def test_phone
    user = UserValidator.new('homework.csv')
    bad_phone = user.check_phone
    assert bad_phone == [0,4,6]
  end

end
