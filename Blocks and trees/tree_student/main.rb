require_relative 'binary_tree'
require_relative 'student'


student1 = Student.new(surname: "Иванов", name: "Иван", middle_name: "Иванович", birth_date: Date.new(2000, 1, 15))
student2 = Student.new(surname: "Петров", name: "Петр", middle_name: "Петрович", birth_date: Date.new(1999, 5, 20))
student3 = Student.new(surname: "Сидоров", name: "Сидор", middle_name: "Сидорович", birth_date: Date.new(2001, 3, 10))


tree = Binary_tree.new
tree.add(student1)
tree.add(student2)
tree.add(student3)

# Вывод отсортированных студентов
tree.each { |student| puts student }
