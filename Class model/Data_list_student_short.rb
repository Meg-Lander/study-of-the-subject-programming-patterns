require_relative 'data_list'
require_relative 'data_table'
require_relative 'Student_short'
require_relative 'Student_List_View'

class Data_list_student_short < Data_list
  attr_accessor :count

  def initialize(data)
    @observers = []
    @count = 0
  end

  def notify
    @observers.each do |observer|
      observer.set_table_params(attribute_names, @count)
      observer.set_table_data(get_data)
    end
  end

  def add_observer(observer)
    @observers << observer
  end

  private

  def extract_attributes(student)
    [student.initials_name, student.git, student.contact]
  end

  def attribute_names
    ["Инициалы", "Git", "Контакты"]
  end
end