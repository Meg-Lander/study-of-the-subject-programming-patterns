require 'json'
require_relative 'data_list'
require_relative 'data_table'
require_relative 'Student_short'
require_relative 'Data_list_student_short'
require_relative 'Student'
require_relative 'Students_list'
require_relative 'strategy_list_file'


class Students_list_JSON < File_strategy
  def read(file_path)
    return [] unless File.exist?(file_path)

    json_data = JSON.parse(File.read(file_path), symbolize_names: true)
    json_data.map { |student_data| Student.new(**student_data) }
  rescue StandardError => e
    raise "Ошибка при чтении JSON файла: #{e.message}"
  end

  def write(file_path, data)
    File.open(file_path, 'w') { |file| file.write(data.map(&:to_h).to_json) }
  rescue StandardError => e
    raise "Ошибка при записи в JSON файл: #{e.message}"
  end
end
