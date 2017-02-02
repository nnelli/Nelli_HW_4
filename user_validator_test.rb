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
    assert_equal [1,3,4,6], bad_joined_dates
  end

  def test_email
    user = UserValidator.new('homework.csv')
    bad_emails = user.check_email
    assert_equal [1,2], bad_emails
  end

  def test_phone
    user = UserValidator.new('homework.csv')
    bad_phone = user.check_phone
    assert_equal [0,2,4,6], bad_phone
  end

  def test_validity
    user = UserValidator.new('homework.csv')
    test_valid = user.check_validity
    assert_equal "Users [1, 3, 4, 6] have incorrect joined dates, users [1, 2] did not enter correct emails, and users [0, 2, 4, 6] did not enter valid phone numbers.", test_valid
  end

end
