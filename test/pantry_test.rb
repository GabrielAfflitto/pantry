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

  def test_that_stock_check_defaults_to_zero_if_item_does_not_exist
    pantry = Pantry.new

    assert_equal 0, pantry.stock_check("Cheese")
  end

  def test_item_can_be_added_and_value_can_be_reassigned
    pantry = Pantry.new
    pantry.restock("Cheese", 10)

    assert_equal 10, pantry.stock_check("Cheese")
  end

  def test_value_can_be_added_instead_of_reassigned_to_item
    pantry = Pantry.new
    pantry.restock("Cheese", 10)
    pantry.restock("Cheese", 20)

    assert_equal 30, pantry.stock_check("Cheese")
  end

  
end
