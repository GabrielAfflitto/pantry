require './lib/pantry'
require 'minitest/autorun'
require 'minitest/pride'

class PantryTest < Minitest::Test
  def test_it_exists
    pantry = Pantry.new

    assert_instance_of Pantry, pantry
  end

  def test_stock_defaults_to_empty_array
    pantry = Pantry.new

    assert_equal ({}), pantry.stock
  end

  def test_that_stock_check_looks_for_given_item
    pantry = Pantry.new

    assert_equal 0, pantry.stock_check("cheese")
  end
end
