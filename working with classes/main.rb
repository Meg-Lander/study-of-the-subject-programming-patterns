require_relative 'Student'

student_ivan = Student.new(id: '1',surname: 'Иванов', name: 'Иван', middle_name: 'Иванович', phone: '12345678901', telegram: '@ivanov')
student_pert = Student.new(surname: 'Петров', name: 'Пётр', middle_name: 'Петрович', telegram: '@petrov', git: 'github.com/petrov')
student_me = Student.new(id: '3', surname: 'Чертоусов', name: 'Владимир', middle_name: 'Сергеевич', phone: '+98765432101', git: 'github.com/Meg-Lander')

student_ivan.show_inf
student_pert.show_inf
student_me.show_inf