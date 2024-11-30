require_relative 'Person'

class Student < Person
  attr_reader :surname, :name, :middle_name

  def initialize(params)
    super(params)
    
    @surname = params[:surname]
    @name = params[:name]
    @middle_name = params[:middle_name]

  end

  def initials
    "#{@surname} #{@name[0]}.#{@middle_name[0]}."
  end

  def getInfo
    "#{initials}; GitHub: #{git_info}; Связь: #{contact_info}"
  end
  
  def show_inf
    puts "id: #{@id}"
    puts "Фамилия: #{@surname}"
    puts "Имя: #{@name}"
    puts "Отчество: #{@middle_name}"
    puts "Номер телефона: #{@phone}"
    puts "Телеграм: #{@telegram}"
    puts "Почта: #{@email}"
    puts "GitHub: #{@git}"
  end

end
