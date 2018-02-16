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

  def films
    sql = "
    SELECT * FROM films
    INNER JOIN tickets ON tickets.customer_id = $1
    WHERE tickets.film_id = films.id;"
    values = [@id]
    results = SqlRunner.run(sql, values)
    results.map {|film| Film.new(film)}
  end

  def number_of_tickets_bought
    films.count
  end


  # CLASS METHODS

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
