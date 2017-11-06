require 'pry'
class Pantry
  attr_reader :stock, :shopping_list, :cookbook
  def initialize
    @stock = Hash.new(0)
    @shopping_list = Hash.new(0)
    @cookbook = []
  end

  def stock_check(item)
    stock[item]
  end

  def restock(item, value)
    stock[item] += value
  end

  def add_to_shopping_list(recipe)
    recipe.ingredients.each_pair do |ingredient, amount|
      shopping_list[ingredient] += amount
    end
  end

  def print_shopping_list
    list = []
    shopping_list.each do |ingredient, amount|
      list << "* #{ingredient}: #{amount}\n"
    end
    list.join.chomp("\n")
  end

  def add_to_cookbook(recipe)
    cookbook << recipe
  end

  def what_can_i_make
    cookbook_select.map { |recipe| recipe.name }
  end

  def cookbook_select
    cookbook.select { |recipe| check_cookbook(recipe) }
  end

  def check_cookbook(recipe)
    recipe.ingredients.each_pair do |key, value|
      break if stock_check(key) < value
    end
  end

  def how_many_can_i_make
    recipes = {}
    cookbook_select.each do |recipe|
      results = []
      amount_calculate(recipes, results, recipe)
    end
    recipes
  end

  def amount_calculate(recipes, results, recipe)
    recipe.ingredients.each_pair do |key, value|
      results << (stock_check(key) / value)
    end
    recipes[recipe.name] = results.max.to_i
  end

end
