require_relative 'Person'

class StudentShort < Person

  attr_reader :contact

  # Метод для создания объекта из объекта Student
  def self.new_obj_student_short(student)
    new(
      id: student.id,
      initials_name: student.initials_name,
      git: student.git,
      contact: student.phone || student.telegram || student.email
    )
  end
  
  # Метод для создания объекта из ID и строки с информацией
  def self.new_string_student_short(id, info)
    parts = info.split(';').map(&:strip)
    raise ArgumentError, 'Некорректная строка информации' unless parts.size == 3
    new(
      id: id,
      initials_name: parts[0],
      git: parts[1].sub('GitHub: ', '').strip,
      contact: parts[2].sub('Связь: ', '').strip
    )
  end

  def to_s
    "#{@id} #{@initials_name} #{@git} #{@contact}"
  end

  private_class_method :new
  private

  def initialize(params)
    @id = params[:id]
    @initials_name = initials_name
    @git = params[:git]
    @contact = params[:contact]
  end
  
end
