require 'CSV'

class UserValidator
  def initialize(filename)
    @filename = filename
    @data = CSV.read(@filename, :headers => true)
  end

  def check_joined
      joined = @data['joined']
      count_limit = joined.count
      count = 0
      bad_rows = []

    while count < count_limit do
      unless joined[count].match(/^(?:(?:(?:(?:0?[13578])|(1[02]))(\/|-)31(\/|-)(19|20)?\d\d)|(?:(?:(?:0?[13-9])|(?:1[0-2]))(\/|-)(?:29|30)(\/|-)(?:19|20)?\d\d)|(?:0?2(\/|-)29(\/|-)(?:19|20)(?:(?:[02468][048])|(?:[13579][26])))|(?:(?:(?:0?[1-9])|(?:1[0-2]))(\/|-)(?:(?:0?[1-9])|(?:1\d)|(?:2[0-8]))(\/|-)(?:19|20)?\d\d))$/) or joined[count].match(/^[0-9]{2}(?:[0-9]{2})?(\/|-)([0-1][0-9]|[0-9])(\/|-)([0-2][0-9]|[0-9]|[1-2][0-9]|[3][0-1])$/)
        bad_rows << count
      end
      count += 1

    end

    bad_rows
  end

  def check_email
      email = @data['email']
      count_limit = email.count
      count = 0
      bad_rows = []

    while count < count_limit do
      unless email[count].match(/^[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+$/)
        bad_rows << count
      end
      count += 1
    end
    bad_rows
  end

  def check_phone
    phone = @data['phone']
    count_limit = phone.count
    count = 0
    bad_rows = []

    while count < count_limit do
      unless phone[count].match(/^(?:(?:\+?1\s*(?:[.-]\s*)?)?(?:\(\s*([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9])\s*\)|([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9]))\s*(?:[.-]\s*)?)?([2-9]1[02-9]|[2-9][02-9]1|[2-9][02-9]{2})\s*(?:[.-]\s*)?([0-9]{4})(?:\s*(?:#|x\.?|ext\.?|extension)\s*(\d+))?$/)
        bad_rows << count
      end
      count += 1
    end
    bad_rows
  end

  def check_validity
    bad_joins = []
    bad_emails = []
    bad_phone = []

    bad_joins = check_joined

    bad_emails = check_email

    bad_phones = check_phone

    bad_passwords = check_password

    "#{bad_joins.count} users #{bad_joins} have incorrect joined dates, #{bad_emails.count} users #{bad_emails} did not enter correct emails, #{bad_phones.count} users #{bad_phones} did not enter valid phone numbers, and #{bad_passwords.count} users #{bad_passwords} have bad passwords."
  end

  def check_password
    passwords = @data['password']
    bad_passwords = []
    word_count = 0
    word_limit = passwords.count
    while word_count < word_limit do
      char_count = 0
      char_limit = passwords[word_count].length
      lower_count = 0
      upper_count = 0
      number_count = 0
      special_count = 0
      appear_in_pw = 0
      while char_count < char_limit do
        if passwords[word_count][char_count].match(/[a-z]/)
          lower_count += 1
        elsif passwords[word_count][char_count].match(/[A-Z]/)
          upper_count +=1
        elsif passwords[word_count][char_count].match(/\d/)
          number_count += 1
        elsif passwords[word_count][char_count].match(/(\W|_)/)
          special_count +=1
        end
        char_count += 1
      end

      if lower_count > 0
        appear_in_pw += 1
      end

      if upper_count > 0
        appear_in_pw += 1
      end

      if number_count > 0
        appear_in_pw += 1
      end

      if special_count > 0
        appear_in_pw += 1
      end



      unless char_limit >= 6 and appear_in_pw >= 3
        bad_passwords << word_count
      end
    word_count += 1
    end
    bad_passwords
  end

end
