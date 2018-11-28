require('pry')
require_relative('models/bounty.rb')
Bounty.delete_all


  bounty1 = Bounty.new({
    'name' => 'Jimmy',
    'species' => 'Martian',
    'bounty_value' => '500',
    'favourite_weapon' => 'Plasma Pistol'
    })

  bounty2 = Bounty.new({
    'name' => 'Gavin',
    'species' => 'Glaswegian',
    'bounty_value' => '1000',
    'favourite_weapon' => 'Space Chib'
    })

  bounty3 = Bounty.new({
    'name' => 'Bryan',
    'species' => 'Dog',
    'bounty_value' => '1',
    'favourite_weapon' => 'Chew Toy'
    })

  bounty1.save
  bounty2.save
  bounty3.save

  bounty2.bounty_value = 5000
  bounty2.update

  bounty3.delete()

  found = Bounty.find_by_name("Scott")

  foundid = Bounty.find_by_id(40)

binding.pry
nil
