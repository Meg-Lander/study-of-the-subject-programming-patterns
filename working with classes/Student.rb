require_relative 'Person'

class Student < Person
  attr_reader :surname, :name, :middle_name

  def initialize(params)
    super(params)
    
    @surname = params[:surname]
    @name = params[:name]
    @middle_name = params[:middle_name]

  end

  private_class_method :initials
  
  def initials
    "#{@surname} #{@name[0]}.#{@middle_name[0]}."
  end

  def getInfo
    "#{initials}; GitHub: #{git_info}; Связь: #{contact_info}"
  end
  
  def show_inf
    "#{@id} #{@surname} #{@middle_name} #{@name}\nGit: #{@git}\nДанные для связи:\nНомер телефона: #{@phone}\nТелеграм: #{@telegram}\nEmail: #{@email}\n\n"
  end

  def self.name_valid?(name)
    name.to_s.match?(/\A[А-ЯA-Z][а-яa-z]{1,}\z/)
  end

  def surname=(names)
    raise ArgumentError, 'Некорректный ID' unless self.name_valid?(names)
    @surname = names
  end

  def middle_name=(names)
    raise ArgumentError, 'Некорректный ID' unless self.name_valid?(names)
    @middle_name = names
  end

  def name=(names)
    raise ArgumentError, 'Некорректный ID' unless self.name_valid?(names)
    @name = names
  end

end