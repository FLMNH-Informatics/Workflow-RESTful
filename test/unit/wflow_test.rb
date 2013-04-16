require 'test_helper'

class WflowTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Wflow.new.valid?
  end
end
