require_relative 'data_list'
require_relative 'data_table'
require_relative 'Student_short'
require_relative 'Data_list_student_short'
require_relative 'Student'
require 'json'
require 'yaml'

class StudentsList
  attr_reader :file_path

  def initialize(file_path)
    @file_path = file_path
  end

  def read_students
    raise NotImplementedError, "This method should be overridden in subclasses"
  end

  def write_students(students)
    raise NotImplementedError, "This method should be overridden in subclasses"
  end

  def find_student_by_id(id)
    students_data = read_students
    student_data = students_data.find { |student| student[:id] == id }
    raise "Студент с ID #{id} не найден" unless student_data

    Student.new(student_data)
  end

  def get_k_n_student_short_list(k, n, data_list = nil)
    students_data = read_students
    total_students = students_data.size

    start_index = (k - 1) * n
    end_index = [start_index + n - 1, total_students - 1].min

    data_list ||= DataListStudentShort.new([])

    selected_students = students_data[start_index..end_index].map do |student_data|
      StudentShort.new_obj_student_short(Student.new(student_data))
    end

    data_list.elements = selected_students
    data_list
  end

  def sort_by_surname_and_initials
    students_data = read_students

    sorted_students = students_data.sort_by do |student|
      "#{student[:surname]} #{student[:name][0]}.#{student[:middle_name][0]}."
    end

    write_students(sorted_students)
    sorted_students
  end

  def add_student(new_student)
    students_data = read_students

    max_id = students_data.map { |student| student[:id] }.max || 0
    new_id = max_id + 1

    new_student_data = {
      id: new_id,
      surname: new_student.surname,
      name: new_student.name,
      middle_name: new_student.middle_name,
      git: new_student.git,
      contact: new_student.phone || new_student.telegram || new_student.email
    }

    students_data << new_student_data
    write_students(students_data)

    new_id
  end

  def replace_student_by_id(id, updated_student)
    students_data = read_students

    index = students_data.find_index { |student| student[:id] == id }
    raise "Студент с ID #{id} не найден" unless index

    students_data[index] = {
      id: id,
      surname: updated_student.surname,
      name: updated_student.name,
      middle_name: updated_student.middle_name,
      git: updated_student.git,
      contact: updated_student.phone || updated_student.telegram || updated_student.email
    }

    write_students(students_data)
  end

  def get_student_short_count
    students = read_students
    students.size
  end

  def delete_student_by_id(student_id)
    students = read_students
    student = students.find { |s| s[:id] == student_id }
    if student
      students.delete(student)
      write_students(students)
    else
      raise "Студент с ID = #{student_id} не найден"
    end
  end
end
