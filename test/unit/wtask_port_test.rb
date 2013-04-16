require 'test_helper'

class WtaskPortTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert WtaskPort.new.valid?
  end
end
