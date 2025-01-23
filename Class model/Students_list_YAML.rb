require_relative 'data_list'
require_relative 'data_table'
require_relative 'Student_short'
require_relative 'Data_list_student_short'
require_relative 'Student'
require_relative 'Students_list'
require 'yaml'

class StudentsListYAML < StudentsList
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
end