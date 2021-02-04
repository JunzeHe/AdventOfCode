require 'spec_helper'

describe Day4 do
  describe '#part1' do
    describe '#parse' do
      it 'reads all lines until the next blank line and returns a hash' do
        sample = <<~ABC.chomp.split("\n")
          ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
          byr:1937 iyr:2017 cid:147 hgt:183cm

          iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
          hcl:#cfa07d byr:1929

          hcl:#ae17e1 iyr:2013
          eyr:2024
          ecl:brn pid:760753108 byr:1931
          hgt:179cm

          hcl:#cfa07d eyr:2025 pid:166559648
          iyr:2011 ecl:brn hgt:59in
        ABC

        parsed = Day4.parse(sample)
        expect(parsed.length).to eq(4)
        expect(parsed).to match_array(
          [
            { 'ecl' => 'gry',
              'pid' => '860033327',
              'eyr' => '2020',
              'hcl' => '#fffffd',
              'byr' => '1937',
              'iyr' => '2017',
              'cid' => '147',
              'hgt' => '183cm' },
            { 'iyr' => '2013',
              'ecl' => 'amb',
              'cid' => '350',
              'eyr' => '2023',
              'pid' => '028048884',
              'hcl' => '#cfa07d',
              'byr' => '1929' },
            { 'hcl' => '#ae17e1',
              'iyr' => '2013',
              'eyr' => '2024',
              'ecl' => 'brn',
              'pid' => '760753108',
              'byr' => '1931',
              'hgt' => '179cm' },
            { 'hcl' => '#cfa07d',
              'eyr' => '2025',
              'pid' => '166559648',
              'iyr' => '2011',
              'ecl' => 'brn',
              'hgt' => '59in' }
          ]
        )
      end
    end

    describe '#valid_passport?' do
      it 'is valid if all 8 fields are present on the passport' do
        passport_hash = { 'ecl' => 'gry',
                          'pid' => '860033327',
                          'eyr' => '2020',
                          'hcl' => '#fffffd',
                          'byr' => '1937',
                          'iyr' => '2017',
                          'cid' => '147',
                          'hgt' => '183cm' }

        expect(Day4.valid_passport?(passport_hash)).to eq(true)
      end

      it 'is valid if the only field missing is CID' do
        passport_hash = { 'hcl' => '#ae17e1',
                          'iyr' => '2013',
                          'eyr' => '2024',
                          'ecl' => 'brn',
                          'pid' => '760753108',
                          'byr' => '1931',
                          'hgt' => '179cm' }

        expect(Day4.valid_passport?(passport_hash)).to eq(true)
      end

      it 'is invalid if fields are missing from the passport' do
        passport_hash = { 'hcl' => '#cfa07d',
                          'eyr' => '2025',
                          'pid' => '166559648',
                          'iyr' => '2011',
                          'ecl' => 'brn',
                          'hgt' => '59in' }

        expect(Day4.valid_passport?(passport_hash)).to eq(false)
      end
    end
  end

  describe '#part2' do
    describe 'more_valid_passport?' do
      it 'is invalid if missing one of the 7 required fields' do
        sample = {
          'eyr' => '2029',
          'ecl' => 'blu',
          'cid' => '129',
          'pid' => '896056539',
          'hcl' => '#a97842',
          'hgt' => '165cm'
        }

        expect(Day4.more_valid_passport?(sample)).to eq(false)
      end

      it 'is valid only if all 7 fields have valid data' do
        sample = {
          'eyr' => '2029',
          'ecl' => 'blu',
          'cid' => '129',
          'byr' => '1989',
          'iyr' => '2014',
          'pid' => '896056539',
          'hcl' => '#a97842',
          'hgt' => '165cm'
        }

        expect(Day4.more_valid_passport?(sample)).to eq(true)
      end
    end
  end
end
