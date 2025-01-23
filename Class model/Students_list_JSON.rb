require 'json'
require_relative 'data_list'
require_relative 'data_table'
require_relative 'Student_short'
require_relative 'Data_list_student_short'
require_relative 'Student'
require_relative 'Person'

class Students_list_JSON
  attr_reader :file_path

  def initialize(file_path)
    @file_path = file_path
  end

  # Чтение всех значений из файла
  def read_students
    return [] unless File.exist?(file_path) # Если файл не существует, возвращаем пустой массив

    file_content = File.read(file_path)
    JSON.parse(file_content, symbolize_names: true)
  rescue JSON::ParserError => e
    raise "Ошибка парсинга файла JSON: #{e.message}"
  end

  # Запись всех значений в файл
  def write_students(students)
    json_data = students.map do |student|
      {
        id: student.id,
        surname: student.surname,
        name: student.name,
        middle_name: student.middle_name,
        git: student.git,
        contact: student.contact
      }
    end

    File.write(file_path, JSON.pretty_generate(json_data))
  rescue IOError => e
    raise "Ошибка записи в файл: #{e.message}"
  end
end
