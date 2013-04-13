require File.join(File.dirname(__FILE__), 'test_helper.rb')

class ApiTest < Test::Unit::TestCase

  def test_got_root?
    get '/'
    assert last_response.ok?
  end

end
