require 'yaml'
class Recipe
  class << self
    def describe(&block)
      if block_given?
        instance_eval(&block)
      else
        raise NotImplementedError
      end
    end

    def recipe(*args, &block)
      if block_given?
        data_holder = DataHolder.new
        args.each do |arg|

          data_holder.recipe_name = arg.downcase
          data_holder.instance_eval(&block)
        end
        data_holder.save_recipe
      else
        raise NotImplementedError
      end
    end

    def for(recipe_name)
      data_holder = DataHolder.new
      data_holder.recipe_name = recipe_name
      data_holder.find_formula
    end
  end

  class DataHolder
    attr_accessor :recipe_name

    def initialize
      @recipe_struct = Struct.new(:name, :ingredients)
      @ingredients = []
    end

    def ingredient(ingredient_name)
      @ingredients << ingredient_name
    end

    def save_recipe
      begin
        file = File.open('recipe_data.yml', 'a+')
        data = [recipe_name, @ingredients].to_yaml
        file.write(data)
      rescue IOError => e
        puts e
      ensure
        file.close
      end
      puts("#{recipe_name} = #{@ingredients}")
    end

    def find
      unless recipe_name.nil?
        data = YAML.load_stream(File.read('./recipe_data.yml'))
        data.each do |elem|
          return elem if elem[0] == recipe_name.downcase
        end
      else
        raise StandardError => e
          puts "Error on name: #{e}"
      end
    end

    def find_formula
      recipe = self.find
      recipe_formula = @recipe_struct.new
      recipe_formula.name = recipe[0]
      recipe_formula.ingredients = recipe[1]
      recipe_formula
    end
  end
end