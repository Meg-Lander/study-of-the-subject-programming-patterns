require_relative 'person'
require_relative 'student'
require_relative 'binary_tree'

students = [
  Student.new(id: 1, surname: 'Иванов', name: 'Иван', middle_name: 'Иванович', birth_date: '2000-05-15'),
  Student.new(id: 2, surname: 'Петров', name: 'Петр', middle_name: 'Петрович', birth_date: '1998-03-20'),
  Student.new(id: 3, surname: 'Сидоров', name: 'Сидор', middle_name: 'Сидорович', birth_date: '2002-11-11')
]

tree = Binary_tree.new
students.each { |student| tree.add(student) }

puts "Студенты в порядке возрастания даты рождения:"
tree.each { |student| puts student }