require_relative 'data_list'
require_relative 'data_table'
require_relative 'Student_short'
require_relative 'Data_list_student_short'
require_relative 'Student'
require 'yaml'

class Students_list_YAML

  def initialize(file_path)
    @file_path = file_path
  end

  def read_students
    return [] unless File.exist?(@file_path)

    YAML.load_file(@file_path) || []
  rescue StandardError => e
    raise "Ошибка при чтении файла: #{e.message}"
  end

  def write_students(students)
    File.open(@file_path, 'w') { |file| file.write(students.to_yaml) }
  rescue StandardError => e
    raise "Ошибка при записи в файл: #{e.message}"
  end


  def get_student_by_id(id)
    students_data = read_students

    student_data = students_data.find { |student| student[:id] == id }
    raise "Студент с ID #{id} не найден" unless student_data

    Student.new(student_data)
  end

  # Получить список k по счету n объектов класса Student_short
  def get_k_n_student_short_list(k, n, existing_data_list = nil)
    students_data = read_students

    start_index = k * n
    end_index = start_index + k - 1

    selected_students = students_data[start_index..end_index]&.map do |student_data|
      StudentShort.new_obj_student_short(Student.new(student_data))
    end

    if existing_data_list
      existing_data_list.elements = selected_students
      existing_data_list
    else
      Data_list_student_short.new(selected_students)
    end
  end

  def sort_by_full_name
    students_data = read_students
    sorted_data = students_data.sort_by do |student|
      "#{student[:surname]} #{student[:name][0]}.#{student[:middle_name][0]}."
    end
    write_students(sorted_data)
  end

  def add_student(student)
    students_data = read_students

    new_id = (students_data.map { |s| s[:id] }.max || 0) + 1
    student_data = {
      id: new_id,
      surname: student.surname,
      name: student.name,
      middle_name: student.middle_name,
      git: student.git,
      phone: student.instance_variable_get(:@phone),
      telegram: student.instance_variable_get(:@telegram),
      email: student.instance_variable_get(:@email),
      birth_date: student.instance_variable_get(:@birth_date)
    }

    students_data << student_data
    write_students(students_data)
    new_id
  end

  def replace_student_by_id(id, new_student)
    students_data = read_students

    index = students_data.find_index { |student| student[:id] == id }
    raise "Студент с ID #{id} не найден" unless index

    new_student_data = {
      id: id,
      surname: new_student.surname,
      name: new_student.name,
      middle_name: new_student.middle_name,
      git: new_student.git,
      phone: new_student.instance_variable_get(:@phone),
      telegram: new_student.instance_variable_get(:@telegram),
      email: new_student.instance_variable_get(:@email),
      birth_date: new_student.instance_variable_get(:@birth_date)
    }

    students_data[index] = new_student_data
    write_students(students_data)
  end

  def delete_student_by_id(id)
    students_data = read_students

    updated_data = students_data.reject { |student| student[:id] == id }
    if updated_data.size == students_data.size
      raise "Студент с ID #{id} не найден"
    end

    write_students(updated_data)
  end

  def get_student_short_count
    read_students.size
  end
end
