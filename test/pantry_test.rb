require './lib/pantry'
require './lib/recipe'
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

  def test_for_recipe_ingredients
      pantry = Pantry.new
      r = Recipe.new("Cheese Pizza")

      assert_equal ({}), r.ingredients
  end

  def test_that_recipe_ingredients_can_be_populated
    pantry = Pantry.new
    r = Recipe.new("Cheese Pizza")
    r.add_ingredient("Cheese", 20)
    r.add_ingredient("Flour", 20)

    assert_equal ({"Cheese" => 20, "Flour" => 20}), r.ingredients
  end

  def test_that_recipe_can_be_added_to_shopping_list
    pantry = Pantry.new
    r = Recipe.new("Cheese Pizza")
    r.add_ingredient("Cheese", 20)
    r.add_ingredient("Flour", 20)
    pantry.add_to_shopping_list(r)

    assert_equal ({"Cheese" => 20, "Flour" => 20}), pantry.shopping_list
  end

  def test_that_different_recipes_can_be_added
    pantry = Pantry.new
    r = Recipe.new("Spaghetti")
    r.add_ingredient("Cheese", 20)
    r.add_ingredient("Flour", 20)
    r.add_ingredient("Spaghetti Noodles", 10)
    r.add_ingredient("Marinara Sauce", 10)
    r.add_ingredient("Cheese", 5)
    pantry.add_to_shopping_list(r)
    list = {"Cheese" => 25, "Flour" => 20, "Spaghetti Noodles" => 10, "Marinara Sauce" => 10}


    assert_equal list, pantry.shopping_list
  end

  def test_shopping_list_can_be_printed
    pantry = Pantry.new
    r = Recipe.new("Spaghetti")
    r.add_ingredient("Cheese", 20)
    r.add_ingredient("Flour", 20)
    r.add_ingredient("Spaghetti Noodles", 10)
    r.add_ingredient("Marinara Sauce", 10)
    r.add_ingredient("Cheese", 5)
    pantry.add_to_shopping_list(r)
    list = "* Cheese: 5\n* Flour: 20\n* Spaghetti Noodles: 10\n* Marinara Sauce: 10"

    assert_equal list, pantry.print_shopping_list
  end

  def test_what_can_I_make
    pantry = Pantry.new

    r1 = Recipe.new("Cheese Pizza")
    r1.add_ingredient("Cheese", 20)
    r1.add_ingredient("Flour", 20)

    r2 = Recipe.new("Pickles")
    r2.add_ingredient("Brine", 10)
    r2.add_ingredient("Cucumbers", 30)

    r3 = Recipe.new("Peanuts")
    r3.add_ingredient("Raw nuts", 10)
    r3.add_ingredient("Salt", 10)

    pantry.add_to_cookbook(r1)
    pantry.add_to_cookbook(r2)
    pantry.add_to_cookbook(r3)

    pantry.restock("Cheese", 10)
    pantry.restock("Flour", 20)
    pantry.restock("Brine", 40)
    pantry.restock("Cucumbers", 120)
    pantry.restock("Raw nuts", 20)
    pantry.restock("Salt", 20)


    assert_equal ["Pickles", "Peanuts"], pantry.what_can_i_make
  end



end
