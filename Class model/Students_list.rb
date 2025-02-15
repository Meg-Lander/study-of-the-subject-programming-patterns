require_relative 'data_list'
require_relative 'data_table'
require_relative 'Student_short'
require_relative 'Data_list_student_short'
require_relative 'Student'
require_relative 'strategy_list_file'
require 'json'
require 'yaml'

class Students_list
  attr_reader :file_path, :file_strategy

  def initialize(file_path, file_strategy)
    @file_path = file_path
    @file_strategy = file_strategy
    @students = read
  end

  def read
    file_strategy.read(file_path)
  end

  def write(students)
    file_strategy.write(file_path, students)
  end

  def find_student_by_id(id)
    students_data = @students
    student_data = students_data.find { |student| student[:id] == id.to_i }
    raise "Студент с ID #{id} не найден" unless student_data

    Student.new(**student_data)
  end

  def get_k_n_student_short_list(k, n, data_list = nil)
    students_data = @students
    total_students = students_data.size

    start_index = (k - 1) * n
    end_index = [start_index + n - 1, total_students - 1].min

    data_list ||= Data_list_student_short.new([])

    selected_students = students_data[start_index..end_index].map do |student_data|
      StudentShort.new_obj_student_short(student_data)
    end

    data_list.elements = selected_students
    data_list
  end

  def sort_by_surname_and_initials
    students_data = @students
    sorted_students = students_data.sort_by do |student|
      "#{student[:surname]} #{student[:name][0]}.#{student[:middle_name][0]}."
    end
    write(sorted_students)
    sorted_students
  end

  def add_student(new_student)
    students_data = @students

    if students_data.any? { |existing| existing == new_student.to_h }
      raise ArgumentError, "Попытка добавить дублирующегося студента: #{new_student.inspect}"
    end

    new_id = (students_data.map { |s| s[:id].to_i }.max || 0) + 1
    new_student_data = new_student.to_h.merge(id: new_id)

    students_data << new_student_data
    write(students_data)

    new_id
  end

  def replace_student_by_id(id, new_student)
    students_data = @students
    index = students_data.find_index { |s| s[:id].to_s == id.to_s }

    if index.nil?
      raise "Студент с ID #{id} не найден."
    end

    unless students_data.any? { |existing| existing == new_student.to_h }
      students_data[index] = new_student.to_h.merge(id: id.to_i)
      write(students_data)
    end
  end


  def get_student_short_count
    @students.size
  end


  def delete_student_by_id(student_id)
    students_data = @students
    student = students_data.find { |s| s[:id] == student_id }
    if student
      students_data.delete(student)
      write(students_data)
    else
      raise "Студент с ID = #{student_id} не найден"
    end
  end
end

