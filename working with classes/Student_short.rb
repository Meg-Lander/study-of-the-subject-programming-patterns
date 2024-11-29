class StudentShort
  
  attr_reader :id, :surname_initials, :git, :contact

  def initialize(student_or_id, info = nil)

    # Конструктор 1: принимает объект Student
    if student_or_id.is_a?(Student)
      student = student_or_id
      @id = student.id
      @surname_initials = "#{student.surname} #{student.name[0]}.#{student.middle_name[0]}."
      @git = student.git
      @contact = student.contact_info

    elsif info
    # Конструктор 2: принимает id и строку с остальной информацией
      @id = student_or_id
      parts = info.split(';').map(&:strip)
      raise ArgumentError, 'Некорректная строка информации' unless parts.size == 3

      @surname_initials = parts[0]
      @git = parts[1].sub('GitHub: ', '').strip
      @contact = parts[2].sub('Связь: ', '').strip


    else
      raise ArgumentError, 'Неверные параметры конструктора'
    end
  end



end
