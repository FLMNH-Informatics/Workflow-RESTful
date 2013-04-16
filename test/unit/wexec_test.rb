require 'test_helper'

class WexecTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Wexec.new.valid?
  end
end
