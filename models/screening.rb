require_relative('../db/sql_runner.rb')

class Screening

  attr_reader :id
  attr_accessor :film_id, :show_time, :max_tickets

  MAX_TICKETS = 5

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @film_id = options['film_id']
    @show_time = options['show_time']
    @max_tickets = MAX_TICKETS
  end

  def save
    sql = "
    INSERT INTO screenings
    (
      film_id, show_time
    )
    VALUES (
      $1, $2
    )
    RETURNING*;"
    values = [@film_id, @show_time]
    @id = SqlRunner.run(sql, values).first['id'].to_i
  end

  def number_of_tickets_bought
    sql = "
      SELECT * FROM tickets
      WHERE tickets.screening_id = $1
    "
    values = [@id]
    results = SqlRunner.run(sql, values)
    results.count
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM screenings WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values).first
    Screening.new(result)
  end

  def self.find_film_by_screening_id(id)
    film_id = Screening.find_by_id(id).film_id
    Film.find_by_id(film_id)
  end

  def self.delete_all
    sql = "DELETE FROM screenings;"
    SqlRunner.run(sql)
  end
end
