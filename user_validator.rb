require 'CSV'

class UserValidator
  def initialize(filename)
    @filename = filename
    @data = CSV.read(@filename, :headers => true)
  end

  def check

    def check_joined
      joined = @data['joined']
      count_limit = joined.count
      count = 0
      bad_rows = []

      while count < count_limit do
        if joined[count].match(/^(?:(?:(?:(?:0?[13578])|(1[02]))(\/|-)31(\/|-)(19|20)?\d\d)|(?:(?:(?:0?[13-9])|(?:1[0-2]))(\/|-)(?:29|30)(\/|-)(?:19|20)?\d\d)|(?:0?2(\/|-)29(\/|-)(?:19|20)(?:(?:[02468][048])|(?:[13579][26])))|(?:(?:(?:0?[1-9])|(?:1[0-2]))(\/|-)(?:(?:0?[1-9])|(?:1\d)|(?:2[0-8]))(\/|-)(?:19|20)?\d\d))$/) or joined[count].match(/^[0-9]{2}(?:[0-9]{2})?(\/|-)([0-1][0-9]|[0-9])(\/|-)([0-2][0-9]|[0-9]|[1-2][0-9]|[3][0-1])$/)
          count += 1
        end
      elsif
        bad_rows << count
      end

      bad_rows
    end

    def check_email
      email = @data['email']
      count_limit = email.count
      count = 0
      bad_rows = []

      while count < count_limit do
        if email[count].match(/^[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+$/)
          count += 1
        end
      elsif
        bad_rows << count
      end

      bad_rows
    end

    def check_phone
      phone = @data['email']
      count_limit = phone.count
      count = 0
      bad_rows = []

      while count < count_limit do
        if phone[count].match(/^(?:(?:\+?1\s*(?:[.-]\s*)?)?(?:\(\s*([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9])\s*\)|([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9]))\s*(?:[.-]\s*)?)?([2-9]1[02-9]|[2-9][02-9]1|[2-9][02-9]{2})\s*(?:[.-]\s*)?([0-9]{4})(?:\s*(?:#|x\.?|ext\.?|extension)\s*(\d+))?$/)
          count += 1
        end
      elsif
        bad_rows << count
      end

      bad_rows
    end
  end

end
