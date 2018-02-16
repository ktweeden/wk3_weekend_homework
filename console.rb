require('pry-byebug')
require_relative('models/customer.rb')
require_relative('models/film.rb')
require_relative('models/ticket.rb')

Customer.delete_all
Film.delete_all

customers = [
  Customer.new({'name' => 'Kate', 'funds' => '50'}),
  Customer.new({'name' => 'Jim', 'funds' => '30'}),
  Customer.new({'name' => 'Paul', 'funds' => '10'}),
  Customer.new({'name' => 'Jane', 'funds' => '40'}),
  Customer.new({'name' => 'Dan', 'funds' => '30'}),
  Customer.new({'name' => 'Jack', 'funds' => '20'}),
  Customer.new({'name' => 'Ada', 'funds' => '40'}),
  Customer.new({'name' => 'Andy', 'funds' => '25'})
]

films = [
  Film.new({'title' => 'Thor', 'price' => '20'}),
  Film.new({'title' => 'Black Panther', 'price' => '10'}),
  Film.new({'title' => 'Chocolat', 'price' => '5'}),
  Film.new({'title' => 'Carol', 'price' => '7'}),
  Film.new({'title' => 'Frozen', 'price' => '8'}),
  Film.new({'title' => 'Power Rangers', 'price' => '10'}),
  Film.new({'title' => 'Okja', 'price' => '1'}),
  Film.new({'title' => 'Die Hard', 'price' => '15'})
]

customers.each { |customer| customer.save}
films.each {|film| film.save}




binding.pry

nil
