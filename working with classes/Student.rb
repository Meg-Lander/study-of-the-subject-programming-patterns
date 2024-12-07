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
    puts "id: #{@id} \n Фамилия: #{@surname}\nИмя: #{@name}; \n Отчество: #{@middle_name}; \n Номер телефона: #{@phone}; \n Телеграм: #{@telegram}; \n Почта: #{@email}; GitHub: #{@git}"
  end

  def reset_full_name(params)
    @surname = params[:surname]
    @name = params[:name]
    @middle_name = params[:middle_name]
  end


end