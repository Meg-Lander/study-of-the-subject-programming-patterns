require_relative 'Person'

class Student < Person
  attr_reader :surname, :name, :middle_name

  def initialize(params)
    super(params)
    
    @surname = params[:surname]
    @name = params[:name]
    @middle_name = params[:middle_name]

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

  def initials_name
    "#{@surname} #{@name[0]}.#{@middle_name[0]}."
  end

  def get_initials_contact
    "#{initials_name}; GitHub: #{@git}; Связь: #{contact_info}"
  end
  
  def to_s
    "#{@id} #{@surname} #{@name} #{@middle_name}\nGit: #{@git}\nДанные для связи:\nНомер телефона: #{@phone}\nТелеграм: #{@telegram}\nEmail: #{@email}\n\n"
  end

  def self.name_valid?(name)
    name.to_s.match?(/\A[А-ЯA-Z][а-яa-z]{1,}\z/)
  end


end
