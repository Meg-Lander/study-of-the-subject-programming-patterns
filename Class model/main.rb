require_relative 'data_list'
require_relative 'data_table'
require_relative 'Student'
require_relative 'Student_short'
require_relative 'Person'
require_relative 'Data_list_student_short'
require 'pg'
require_relative 'Students_list_DB'


# student = Student.new(
#   id: 1,
#   surname: "Иванов",
#   name: "Иван",
#   middle_name: "Иванович",
#   git: "github.com/ivanov",
#   phone: "+00123456789"
# )

# students = [
#   StudentShort.new_obj_student_short(student),
#   StudentShort.new_string_student_short(
#     2, "Петров А.А.; GitHub: github.com/petrov; Связь: @petrov"
#   )
# ]

# data_list = Data_list_student_short.new(students)

# puts "Имена столбцов: #{data_list.get_names.join(', ')}"

# puts "До замены элементов:"
# puts data_list.get_data

# new_students = [
#   StudentShort.new_string_student_short(
#     3, "Сидоров С.С.; GitHub: github.com/sidorov; Связь: sid.sidorov@example.com"
#   )
# ]
# data_list.elements = new_students 

# puts "После замены элементов:"
# puts data_list.get_data


db_params = { host: 'localhost', dbname: 'student_db', user: 'postgres', password: '123' }
students_list_db = Students_list_DB.new(db_params)

student = students_list_db.get_student_by_id(1)
puts student.surname

data_list = students_list_db.get_k_n_student_short_list(1, 10)  # Получить студентов с 1 по 10
puts "#{data_list}"

new_student = Student.new(surname: 'Иванов', name: 'Иван', middle_name: 'Иванович', git: 'github.com/ivanov', email: 'email@domain.com')
new_student_id = students_list_db.add_student(new_student)
puts "New student ID: #{new_student_id}"

updated_student = Student.new(surname: 'Петров', name: 'Петр', middle_name: 'Петрович', git: 'github.com/petrov', email: 'petrov@mail.com')
students_list_db.replace_student_by_id(1, updated_student)

students_list_db.delete_student_by_id(2)

puts "Количество студентов: #{students_list_db.get_student_count}"

students_list_db.close
