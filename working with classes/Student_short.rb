require_relative 'Person'

class StudentShort < Person

  attr_reader :surname_initials, :contact

  # Метод для создания объекта из объекта Student
  def self.new_obj_student_short(student)
    new(
      id: student.id,
      surname_initials: "#{student.surname} #{student.name[0]}.#{student.middle_name[0]}.",
      git: student.git,
      contact: student.contact_info
    )
  end

  # Метод для создания объекта из ID и строки с информацией
  def self.new_string_student_short(id, info)
    parts = info.split(';').map(&:strip)
    raise ArgumentError, 'Некорректная строка информации' unless parts.size == 3
    new(
      id: id,
      surname_initials: parts[0],
      git: parts[1].sub('GitHub: ', '').strip,
      contact: parts[2].sub('Связь: ', '').strip
    )
  end
  
  private_class_method :new
  private

  def initialize(params)
    @id = params[:id]
    @surname_initials = params[:surname_initials]
    @git = params[:git]
    @contact = params[:contact]
  end
  
end
