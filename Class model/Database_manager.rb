require_relative 'data_list'
require_relative 'data_table'
require_relative 'Student_short'
require_relative 'Data_list_student_short'
require_relative 'Student'
require_relative 'strategy_list_file'
require 'pg'
require_relative 'Student'

class Database_manager
  @instance = nil

  private_class_method :new

  def self.instance(db_params)
    @instance ||= new(db_params)
  end

  def initialize(db_params)
    @conn = PG.connect(db_params)
    puts "Подключение к базе данных установлено."
  end

  def execute_query(query, params = [])
    @conn.exec_params(query, params)
  end

  def close
    @conn.close
    puts "Подключение к базе данных закрыто."
    self.class.instance_variable_set(:@instance, nil) # Уничтожение экземпляра
  end
end

