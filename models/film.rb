require_relative('../db/sql_runner.rb')

class Film
  attr_reader :title, :price, :id
  attr_writer :title
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
    @id = SqlRunner.run(sql, values).first['id']
  end

  def update
    sql = "
    UPDATE films
    SET (
      title, price
    ) = (
      $1, $2
    )
    WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end
end