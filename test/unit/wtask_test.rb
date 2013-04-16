require 'test_helper'

class WtaskTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Wtask.new.valid?
  end
end
