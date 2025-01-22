require_relative 'data_list'
require_relative 'data_table'

class Data_list_student_short < Data_list
  def attribute_names
    ["Инициалы", "Git", "Контакты"]
  end

  def extract_attributes(student)
    [student.initials_name, student.git, student.contact]
  end
end