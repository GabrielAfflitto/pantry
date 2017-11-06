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
    b = recipe.ingredients.each_pair do |ingredient, amount|
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
    cookbook.map do |recipe|
      recipe.name
    end
  end

end
