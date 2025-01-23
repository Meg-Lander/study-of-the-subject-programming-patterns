require 'json'
require_relative 'data_list'
require_relative 'data_table'
require_relative 'Student_short'
require_relative 'Data_list_student_short'
require_relative 'Student'
require_relative 'Students_list'

class StudentsListJSON < StudentsList
  def read_students
    return [] unless File.exist?(@file_path)
    JSON.parse(File.read(@file_path), symbolize_names: true)
  end

  def write_students(students)
    File.open(@file_path, 'w') do |file|
      file.write(students.to_json)
    end
  end
end