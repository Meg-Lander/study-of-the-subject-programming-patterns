class Student


   def initialize(params)
    
    @surname = params[:surname]
    @name = params[:name]
    @middle_name = params[:middle_name]
    @id = params[:id]
    @phone = params[:phone]
    @telegram = params[:telegram]
    @email = params[:email]
    @git = params[:git]

  end

  attr_accessor :id, :surname, :name, :middle_name, :phone, :telegram, :email, :git



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
