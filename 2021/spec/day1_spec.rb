require "spec_helper"

describe Day1 do
  describe "#read_from_file" do
    it "returns an array of numbers" do
      input = Day1::read_from_file
			expect(input).to be_a(Array)
			expect(input.first).to be_a(Integer)
    end
  end

  describe "#find_number_pairs" do
    let(:input) do
      (1...50).to_a + [2000]
    end
    it "returns an array of two numbers that add up to argument" do
      numbers = Day1::find_number_pairs(input, 2020)
      sum = numbers.reduce(:+)
      expect(sum).to eq(2020)
    end
  end

  describe "#find_number_triplets" do
    let(:input) do
      (20...50).to_a + [1975]
    end
    it "returns an array of three numbers that add upto argument" do
      numbers = Day1::find_number_triplets(input, 2020)
      require "pry"; binding.pry
      sum = numbers.reduce(:+)
      expect(sum).to eq(2020)
    end
  end
end
