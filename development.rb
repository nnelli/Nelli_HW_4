require './user_validator.rb'

data = UserValidator.new('homework.csv')

data.check_phone
