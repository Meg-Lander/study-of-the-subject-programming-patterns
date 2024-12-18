require_relative 'person'
require 'date'

class Student < Person
  attr_reader :surname, :name, :middle_name, :birth_date

  def initialize(params)
    super(params)

    self.surname = params[:surname]
    self.name = params[:name]
    self.middle_name = params[:middle_name]
    self.birth_date = params[:birth_date]
  end

  def surname=(value)
    raise ArgumentError, 'Некорректная фамилия' unless self.class.name_valid?(value)
    @surname = value
  end

  def name=(value)
    raise ArgumentError, 'Некорректное имя' unless self.class.name_valid?(value)
    @name = value
  end

  def middle_name=(value)
    raise ArgumentError, 'Некорректное отчество' unless self.class.name_valid?(value)
    @middle_name = value
  end

  def birth_date=(value)
    raise ArgumentError, 'Некорректная дата рождения' unless value.is_a?(Date)
    @birth_date = value
  end

  def get_initials_contact
    "#{initials_name}; GitHub: #{@git}; Связь: #{contact_info}"
  end

  def initials_name
    "#{@surname} #{@name[0]}.#{@middle_name[0]}."
  end

  def to_s
    "#{@id} #{@surname} #{@name} #{@middle_name} (Дата рождения: #{@birth_date})\nGit: #{@git}\nДанные для связи:\nНомер телефона: #{@phone}\nТелеграм: #{@telegram}\nEmail: #{@email}\n\n"
  end

  def self.name_valid?(name)
    name.to_s.match?(/\A[А-ЯA-Z][а-яa-z]{1,}\z/)
  end
end
