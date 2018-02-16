require_relative('../db/sql_runner.rb')

class Customer
  attr_reader :name, :funds, :id
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
    @id = SqlRunner.run(sql, values).first['id']
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

  def self.find_by_id(id)
    sql = "SELECT * FROM customers WHERE id = $1;"
    values = [id]
    results = SqlRunner.run(sql, values)
    results.map {|customer| Customer.new(customer)}
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
