require_relative('../db/sql_runner.rb')

class Film
  attr_reader :id
  attr_accessor :title, :price
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i
  end

  def save
    sql = "
    INSERT INTO films
    (
      title, price
    )
    VALUES (
      $1, $2
    )
    RETURNING *;
    "
    values = [@title, @price]
    @id = SqlRunner.run(sql, values).first['id'].to_i
  end

  def update
    sql = "
    UPDATE films
    SET (
      title, price
    ) = (
      $1, $2
    )
    WHERE id = $3;"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def customers
    sql = "
    SELECT * FROM customers
    INNER JOIN screenings ON screenings.film_id = $1
    INNER JOIN tickets ON tickets.customer_id = customers.id
    WHERE tickets.screening_id = screenings.id;
    "
    values = [@id]
    results = SqlRunner.run(sql, values)
    results.map  {|customer| Customer.new(customer)}
  end

  # FIRST
  #
  # def number_of_customers_viewing
  #   customers.count
  # end

  def number_of_customers_viewing
    sql = "
    SELECT COUNT (*)
    FROM customers
    INNER JOIN screenings ON screenings.film_id = $1
    INNER JOIN tickets ON tickets.customer_id = customers.id
    WHERE tickets.screening_id = screenings.id;
    "
    values = [@id]
    result = SqlRunner.run(sql, values).first['count']
  end

  def screenings
    sql = "
    SELECT * FROM screenings
    WHERE film_id = $1;"
    values = [@id]
    results = SqlRunner.run(sql, values)
    results.map {|screening| Screening.new(screening)}
  end

  def most_popular_screening
    most_tickets = 0
    current_highest = {}
    screenings.each do |screening|
      if screening.number_of_tickets_bought > most_tickets
        current_highest = screening
        most_tickets = screening.number_of_tickets_bought
      end
      return current_highest
    end
  end

  def self.delete_by_id(id)
    sql = "DELETE FROM films WHERE id = $1;"
    values = [id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql = "DELETE FROM films;"
    SqlRunner.run(sql)
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM films WHERE id = $1;"
    values = [id]
    result = SqlRunner.run(sql, values).first
    Film.new(result)
  end
end
