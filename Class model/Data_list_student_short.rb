require_relative 'data_list'
require_relative 'data_table'

class Data_list_student_short < DataList
  
  def get_names
    ["№", "Инициалы", "Git", "Контакты"]
  end

  def get_data
    data = @elements.map.with_index do |student, index|
      [index + 1, student.initials_name, student.git, student.contact]
    end
    Data_table.new(data)
  end
end
