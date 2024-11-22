class Student


  def initialize(surname:, name:, middle_name:, id: nil, phone: nil, telegram: nil, email: nil, git: nil)
    
    @surname = surname
    @name = name
    @middle_name = middle_name
    @id = id
    @phone = phone
    @telegram = telegram
    @email = email
    @git = git
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
