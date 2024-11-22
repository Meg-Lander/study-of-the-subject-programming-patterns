class Student


   def initialize(params)

    @surname = params[:surname]
    @name = params[:name]
    @middle_name = params[:middle_name]
    @id = params[:id]

    if params[:phone] && !Student.phone_valid?(params[:phone])
      raise ArgumentError, "Некорректный телефонный номер: #{params[:phone]}"
    end

    @phone = params[:phone]
    @telegram = params[:telegram]
    @email = params[:email]
    @git = params[:git]

  end

  def self.phone_valid?(phone)
    phone.to_s.match?(/^(\d{11}|\+\d{11})$/)
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
