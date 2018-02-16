require('pg')

class SqlRunner
  def self.run(sql, values = [])
    begin
      db = PG.connect({dbname: 'code_clan_cinema', host: 'localhost'})
      db.prepare('query', sql)
      result = db.exec_prepared('quary', values)
    ensure
      db.close
    end
    result
  end

end
