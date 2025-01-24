require_relative 'data_list'
require_relative 'data_table'
require_relative 'Student_short'
require_relative 'Data_list_student_short'
require_relative 'Student'
require_relative 'strategy_list_file'
require 'pg'
require_relative 'Student'

class Database_manager
  def initialize(db_params)
    @db_manager = Students_list_DB.new(db_params)
  end

  def close
    @db_manager.close
  end

  # a. Получить объект класса Student по ID
  def get_student_by_id(id)
    @db_manager.get_student_by_id(id)
  end

  # b. Получить список k по счету n объектов класса Student_short
  def get_k_n_student_short_list(k, n)
    @db_manager.get_k_n_student_short_list(k, n)
  end

  # c. Добавить объект класса Student в список
  def add_student(new_student)
    @db_manager.add_student(new_student)
  end

  # d. Заменить элемент списка по ID
  def replace_student_by_id(id, updated_student)
    @db_manager.replace_student_by_id(id, updated_student)
  end

  # e. Удалить элемент списка по ID
  def delete_student_by_id(id)
    @db_manager.delete_student_by_id(id)
  end

  # f. Получить количество элементов
  def get_student_count
    @db_manager.get_student_count
  end
end
