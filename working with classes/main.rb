require_relative 'Student'

student_ivan = Student.new('Иванов', 'Иван', 'Иванович', 1, '123456789', '@ivanov', 'ivanov@mail.com', 'github.com/ivanov')
student_pert = Student.new('Петров', 'Пётр', 'Петрович', 2, '987654321', '@petrov', nil, 'github.com/petrov')
student_me = Student.new('Чертоусов','Владимир','Сергеевич', 3, '987654321', nil, nil,'github.com/Meg-Lander')

student_ivan.show_inf
student_pert.show_inf
student_me.show_inf