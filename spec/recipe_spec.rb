require 'rspec'
require_relative '../recipe.rb'

describe 'Recipe#describe' do
  let(:success_message) { 'Recipe save success' }
  let(:wrong_message) { 'Pass a block' }
  let(:recipe_name) { 'cake' }
  let(:ingredient) { 'cocoa' }
  let(:ingredient2) { 'flour' }
  let(:right_describe) do
    Recipe.describe do
      recipe 'cake' do
        ingredient 'cocoa'
        ingredient 'flour'
      end
    end
  end

  let(:right_for) { Recipe.for(recipe_name) }

  let(:wrong_describe) { Recipe.describe }

  it 'should return Success Message' do
    expect(right_describe).to eq(success_message)
  end

  it 'should return wrong message' do
    expect(wrong_describe).to eq(wrong_message)
  end

  it 'should return right name' do
    expect(right_for.name).to eq(recipe_name.downcase)
  end

  it 'should return right ingredient' do
    expect(right_for.ingredients).to eq([ingredient, ingredient2])
  end
end