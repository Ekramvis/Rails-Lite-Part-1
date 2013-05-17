require_relative 'db_connection'


# DBConnection.execute()

class SQLObject < MassObject

	def self.set_table_name(name)
		@name = name
	end

	def self.table_name
		@name
	end

	def self.all
		query = <<-SQL
			SELECT *
			  FROM #{self.table_name}
		SQL

		results = DBConnection.execute(query)

		results.map do |result|
			self.new(result)
		end
	end


  def self.find(id)
    query = <<-SQL
      SELECT n.*
        FROM #{self.table_name} AS n
       WHERE n.id = ?
    SQL

    result = DBConnection.execute(query, id)

    self.new(result[0])
  end

  def save
    self.create
  end

  def create
    vars = self.class.attributes.map(&:to_s)
    question_marks = ['?'] * self.class.attributes.count
    values = vars.map { |iv| self.send(iv)  }

    vars = vars.join(", ")
    question_marks = question_marks.join(", ")

    query = <<-SQL
      INSERT INTO #{self.class.table_name} (#{vars})
           VALUES (#{question_marks})
    SQL

    DBConnection.execute(query, *values)
    self.id = DBConnection.last_insert_row_id
  end


  def update(params)

    params.map do |column, value|

    end

    query = <<-SQL
      INSERT INTO #{self.class.table_name}
              SET (#{})
            WHERE id = #{self.id}
    SQL


  end

end
