require_relative 'data_list'
require_relative 'data_table'
require_relative 'Student'
require_relative 'Student_short'
require_relative 'Person'
require_relative 'Data_list_student_short'
require 'pg'
require_relative 'Students_list_DB'
require_relative 'Database_manager'


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



db_params = {
  dbname: 'student_db',
  user: 'postgres',
  password: '123',
  host: 'localhost'
}

db_manager1 = Database_manager.instance(db_params)

db_manager2 = Database_manager.instance(db_params)

puts db_manager1.object_id == db_manager2.object_id

db_manager1.execute_query('SELECT COUNT(*) FROM students') do |result|
  puts "Количество студентов: #{result[0]['count']}"
end

students_db = Students_list_DB.new

new_student = Student.new(
  surname: 'Иванов',
  name: 'Иван',
  middle_name: 'Иванович',
  git: 'github.com/ivanov',
  phone: '+79991234567',
  email: 'ivanov@example.com',
  telegram: '@ivanov'
)
id = students_db.add_student(new_student)
puts "Добавлен студент с ID: #{id}"

student = students_db.get_student_by_id(id)
puts "Получен студент: #{student}"


db_manager1.close

db_manager3 = Database_manager.instance(db_params)
puts db_manager1.object_id == db_manager3.object_id # false (новое подключение)

