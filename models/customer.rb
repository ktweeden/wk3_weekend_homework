require_relative('../db/sql_runner.rb')

class Customer
  attr_reader :id
  attr_accessor :name, :funds
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save
    sql = "
    INSERT INTO customers
    (
      name,
      funds
    )
    VALUES (
      $1, $2
    ) RETURNING *;"
    values = [@name, @funds]
    @id = SqlRunner.run(sql, values).first['id'].to_i
  end

  def update
    sql = "
    UPDATE customers
    SET (
      name, funds
    ) = (
      $1, $2
    )
    WHERE id = $3;"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def reduce_funds(amount)
    @funds -= amount
    sql = "
    UPDATE customers
    SET (
      name, funds
    ) = (
      $1, $2
    )
    WHERE id = $3;"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  # FIRST
  #
  # def films
  #   sql = "
  #   SELECT * FROM films
  #   WHERE id = $1;"
  #   films = screenings.map do |screening|
  #     film = SqlRunner.run(sql, [screening.film_id]).first
  #     Film.new(film)
  #   end
  #   films.uniq {|film| film.id}
  # end

  def films
    sql = "SELECT * FROM films
    INNER JOIN tickets ON tickets.customer_id = $1
    INNER JOIN screenings ON screenings.film_id = films.id
    WHERE tickets.screening_id = screenings.id;
    "
    values = [@id]
    results = SqlRunner.run(sql, values)
    result_map = results.map {|film| Film.new(film)}
    result_map.uniq {|film| film.id}
  end

  def screenings
    sql = "
      SELECT * FROM screenings
      INNER JOIN tickets ON tickets.customer_id = $1
      WHERE tickets.screening_id = screenings.id;"
      values = [@id]
      results = SqlRunner.run(sql, values)
      results.map {|screening| Screening.new(screening)}
  end

  # def number_of_tickets_bought
  #   screenings.count
  # end
  #
  # def number_of_film_seen
  #   films.count
  # end

  def number_of_tickets_bought
    sql = "
      SELECT COUNT (*)
      FROM screenings
      INNER JOIN tickets ON tickets.customer_id = $1
      WHERE tickets.screening_id = screenings.id;"
      values = [@id]
      results = SqlRunner.run(sql, values).first['count']
  end

  def number_of_films_seen
    sql = "SELECT COUNT (DISTINCT title)
    FROM films
    INNER JOIN tickets ON tickets.customer_id = $1
    INNER JOIN screenings ON screenings.film_id = films.id
    WHERE tickets.screening_id = screenings.id;
    "
    values = [@id]
    results = SqlRunner.run(sql, values).first['count']
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM customers WHERE id = $1;"
    values = [id]
    result = SqlRunner.run(sql, values).first
    Customer.new(result)
  end

  def self.delete_all
    sql = "
    DELETE FROM customers;
    "
    SqlRunner.run(sql)
  end

  def self.delete_by_id(id)
    sql = "
    DELETE FROM customers
    WHERE id = $1;
    "
    values = [id]
    SqlRunner.run(sql, values)
  end
end
