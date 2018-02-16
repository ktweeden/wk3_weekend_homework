require('pry-byebug')
require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')
require_relative('models/screening')

Ticket.delete_all
Screening.delete_all
Customer.delete_all
Film.delete_all

customers = [
  Customer.new({'name' => 'Kate', 'funds' => '50'}),
  Customer.new({'name' => 'Jim', 'funds' => '30'}),
  Customer.new({'name' => 'Paul', 'funds' => '60'}),
  Customer.new({'name' => 'Jane', 'funds' => '40'}),
  Customer.new({'name' => 'Dan', 'funds' => '30'}),
  Customer.new({'name' => 'Jack', 'funds' => '20'}),
  Customer.new({'name' => 'Ada', 'funds' => '40'}),
  Customer.new({'name' => 'Andy', 'funds' => '25'})
]

films = [
  Film.new({'title' => 'Thor', 'price' => '2'}),
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

tickets = [
  Ticket.new({'customer_id' => customers[0].id, 'film_id' => films[7].id}),
  Ticket.new({'customer_id' => customers[1].id, 'film_id' => films[6].id}),
  Ticket.new({'customer_id' => customers[2].id, 'film_id' => films[7].id}),
  Ticket.new({'customer_id' => customers[5].id, 'film_id' => films[4].id}),
  Ticket.new({'customer_id' => customers[4].id, 'film_id' => films[3].id}),
  Ticket.new({'customer_id' => customers[6].id, 'film_id' => films[1].id}),
  Ticket.new({'customer_id' => customers[2].id, 'film_id' => films[1].id}),
  Ticket.new({'customer_id' => customers[5].id, 'film_id' => films[5].id}),
  Ticket.new({'customer_id' => customers[7].id, 'film_id' => films[5].id}),
  Ticket.new({'customer_id' => customers[0].id, 'film_id' => films[3].id})
]

screenings = [
  Screening.new({'film_id' => films[0].id, 'show_time' => '09:00:00'}),
  Screening.new({'film_id' => films[0].id, 'show_time' => '11:15:00'}),
  Screening.new({'film_id' => films[0].id, 'show_time' => '15:00:00'}),
  Screening.new({'film_id' => films[0].id, 'show_time' => '17:00:00'}),
  Screening.new({'film_id' => films[1].id, 'show_time' => '10:45:00'}),
  Screening.new({'film_id' => films[1].id, 'show_time' => '12:00:00'}),
  Screening.new({'film_id' => films[1].id, 'show_time' => '14:00:00'}),
  Screening.new({'film_id' => films[2].id, 'show_time' => '16:00:00'}),
  Screening.new({'film_id' => films[2].id, 'show_time' => '18:00:00'}),
  Screening.new({'film_id' => films[3].id, 'show_time' => '12:30:00'}),
  Screening.new({'film_id' => films[3].id, 'show_time' => '17:00:00'}),
  Screening.new({'film_id' => films[3].id, 'show_time' => '20:00:00'}),
  Screening.new({'film_id' => films[4].id, 'show_time' => '21:30:00'}),
  Screening.new({'film_id' => films[4].id, 'show_time' => '22:00:00'}),
  Screening.new({'film_id' => films[5].id, 'show_time' => '10:00:00'}),
  Screening.new({'film_id' => films[5].id, 'show_time' => '12:00:00'}),
  Screening.new({'film_id' => films[5].id, 'show_time' => '17:45:00'}),
  Screening.new({'film_id' => films[6].id, 'show_time' => '10:15:00'}),
  Screening.new({'film_id' => films[6].id, 'show_time' => '13:30:00'}),
  Screening.new({'film_id' => films[6].id, 'show_time' => '18:20:00'}),
  Screening.new({'film_id' => films[6].id, 'show_time' => '20:35:00'}),
  Screening.new({'film_id' => films[7].id, 'show_time' => '15:00:00'}),
  Screening.new({'film_id' => films[7].id, 'show_time' => '17:00:00'}),
  Screening.new({'film_id' => films[7].id, 'show_time' => '19:50:00'}),
  Screening.new({'film_id' => films[7].id, 'show_time' => '22:40:00'})
]

tickets.each {|ticket| ticket.save}
screenings.each {|screening| screening.save}



binding.pry

nil
