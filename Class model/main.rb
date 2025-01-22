require_relative 'data_list'
require_relative 'data_table'
require_relative 'Student'
require_relative 'Student_short'
require_relative 'Person'
require_relative 'Data_list_student_short'


student = Student.new(
  id: 1,
  surname: "Иванов",
  name: "Иван",
  middle_name: "Иванович",
  git: "github.com/ivanov",
  phone: "+00123456789"
)

students = [
  StudentShort.new_obj_student_short(student),
  StudentShort.new_string_student_short(
    2, "Петров А.А.; GitHub: github.com/petrov; Связь: @petrov"
  )
]

data_list = Data_list_student_short.new(students)

puts "Имена столбцов: #{data_list.get_names.join(', ')}"

puts "До замены элементов:"
puts data_list.get_data

new_students = [
  StudentShort.new_string_student_short(
    3, "Сидоров С.С.; GitHub: github.com/sidorov; Связь: sid.sidorov@example.com"
  )
]
data_list.elements = new_students 

puts "После замены элементов:"
puts data_list.get_data
