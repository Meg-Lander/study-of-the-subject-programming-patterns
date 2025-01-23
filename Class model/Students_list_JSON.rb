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
    JSON.parse(File.read(file_path), symbolize_names: true)
  end

  def write(file_path, data)
    File.open(file_path, 'w') { |file| file.write(data.to_json) }
  end
end