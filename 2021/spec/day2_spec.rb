require 'spec_helper'

describe Day2 do
  describe '.parse' do
    it 'parses a line of input and returns object of Password type' do
      line = '8-10 g: gggggggggg'
      parsed = Day2.parse(line)

      expect(parsed).to be_a(Day2::Password)
      expect(parsed.first_num).to eq(8)
      expect(parsed.second_num).to eq(10)
      expect(parsed.letter).to eq('g')
      expect(parsed.password).to eq('gggggggggg')
    end
  end

  describe Day2::Password do
    describe '#is_valid_password?' do
      it 'returns true if the password contains enough of a letter' do
        password = Day2::Password.new(first_num: 8, second_num: 10, letter: 'g', password: 'ggggggggg')
        expect(password.valid?).to eq true
      end

      it 'returns false if the password does not contain enough of a letter' do
        password = Day2::Password.new(first_num: 6, second_num: 13, letter: 'b', password: ' rrrzvtrgrhqxqrvrvwzrbbb')
        expect(password.valid?).to eq false
      end
    end

    describe '#.new_valid?' do
      it 'returns true if letter only occurs once at the two locations' do
        password = Day2::Password.new(
          first_num: 1,
          second_num: 3,
          letter: 'a',
          password: 'abcde'
        )
        expect(password.new_valid?).to eq(true)
      end

      it 'returns false if the letter does not occur at either location' do
        password = Day2::Password.new(
          first_num: 1,
          second_num: 3,
          letter: 'b',
          password: 'cdefg'
        )
        expect(password.new_valid?).to eq(false)
      end

      it 'returns false if the ltter occurs at both locations' do
        password = Day2::Password.new(
          first_num: 1,
          second_num: 3,
          letter: 'c',
          password: 'cdcfg'
        )
        expect(password.new_valid?).to eq(false)
      end
    end
  end
end
