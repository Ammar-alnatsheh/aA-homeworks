require 'rspec'
require 'dessert'

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)! Be sure to look over the solutions when you're done.
=end

describe Dessert do
  subject(:cookies){Dessert.new("cookies", 10, "ammar")}
  let(:chef) { double("chef", name: "ammar") }

  describe "#initialize" do
    it "sets a type" do
      expect(cookies.type).to eq("cookies")
    end

    it "sets a quantity" do
      expect(cookies.quantity).to eq(10)
    end

    it "starts ingredients as an empty array" do
      expect(cookies.ingredients).to eq([])
    end

    it "raises an argument error when given a non-integer quantity" do
      expect { Dessert.new("cake", "tons", chef) }.to raise_error(ArgumentError)
    end
  end

  describe "#add_ingredient" do
    it "adds an ingredient to the ingredients array" do
      cookies.add_ingredient("sugar")
      expect(cookies.ingredients).to include("sugar")
  end

  describe "#mix!" do
    it "shuffles the ingredient array" do
      ["water","eggs","flour"].each do |ingredient|
        cookies.add_ingredient(ingredient)
      end
      expect(cookies.ingredients).to eq(["water","eggs","flour"])
      brownie.mix!
      expect(cookies.ingredients).not_to eq(["water","eggs","flour"])
      expect(brownie.ingredients.sort).to eq(["water","eggs","flour"].sort)
  end

  describe "#eat" do
    it "subtracts an amount from the quantity" do
      cookies.eat(5)
      expect(cookies.quantity).to eq(5)
    end

    it "raises an error if the amount is greater than the quantity" do
      expect { cookies.eat(15)}.to raise_error("not enough left!")
    end
  end

  describe "#serve" do
    it "contains the titleized version of the chef's name" do
      allow(chef).to receive(:titleize).and_return("Chef Tucker the Great Baker")
      expect(brownie.serve).to eq("Chef Tucker the Great Baker has made 100 brownies!")
    end
  end

  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in" do
      expect(ammar).to receive(:bake).with(cookies)
      cookies.make_more
    end
  end
end
