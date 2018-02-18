require_relative('../db/sql_runner')
require_relative('film')
require_relative('customer')

class Ticket
  attr_reader :id
  attr_accessor :customer_id, :screening_id
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i
    @screening_id = options['screening_id'].to_i
  end

  def save
    customer = Customer.find_by_id(@customer_id)
    return nil if customer.funds < get_price_of_film
    customer.reduce_funds(get_price_of_film)
    sql = "INSERT INTO tickets
    (
      customer_id, screening_id
    )
    VALUES(
      $1, $2
    )
    RETURNING*;"
    values = [@customer_id, @screening_id]
    @id = SqlRunner.run(sql, values).first['id'].to_i
  end

  def get_price_of_film
    Screening.find_film_by_screening_id(@screening_id).price
  end

  def update
    sql = "
    UPDATE tickets
    SET (
      customer_id, screening_id
    ) = (
      $1, $2
    )
    WHERE id = $3;"
    values = [@customer_id, @screening_id, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql = "DELETE FROM tickets;"
    SqlRunner.run(sql)
  end

  def self.delete_by_id(id)
    sql = "DELETE FROM tickets WHERE id = $1;"
    values = [id]
    SqlRunner.run(sql, values)
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM tickets WHERE id = $1;"
    values = [id]
    result = SqlRunner.run(sql, values).first
    Ticket.new(result)
  end
end
