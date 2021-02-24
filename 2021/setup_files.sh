# !/bin/bash

DAY=$1

cp app/day_x.rb "app/day${DAY}.rb"
cp spec/day_x_spec.rb "spec/day${DAY}_spec.rb"

sed -i "s/X/${DAY}/g" "app/day${DAY}.rb"
sed -i "s/X/${DAY}/g" "spec/day${DAY}_spec.rb"
