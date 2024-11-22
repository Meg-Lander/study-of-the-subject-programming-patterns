class Student


   def initialize(params)

    @surname = params[:surname]
    @name = params[:name]
    @middle_name = params[:middle_name]

    if params[:id] && !Student.id_valid?(params[:id])
      raise ArgumentError, "Некорректный id: #{params[:id]}"
    end
    @id = params[:id]

    if params[:phone] && !Student.phone_valid?(params[:phone])
      raise ArgumentError, "Некорректный телефонный номер: #{params[:phone]}"
    end
    @phone = params[:phone]

    if params[:telegram] && !Student.telegram_valid?(params[:telegram])
      raise ArgumentError, "Некорректный Telegram: #{params[:telegram]}"
    end
    @telegram = params[:telegram]

    if params[:email] && !Student.email_valid?(params[:email])
      raise ArgumentError, "Некорректный Email: #{params[:email]}"
    end
    @email = params[:email]

    if params[:git] && !Student.git_valid?(params[:git])
      raise ArgumentError, "Некорректный GitHub: #{params[:git]}"
    end
    @git = params[:git]

  end

  def self.id_valid?(id)
    id.to_s.match?(/^\d+$/)
  end

  def self.phone_valid?(phone)
    phone.to_s.match?(/^(\d{11}|\+\d{11})$/)
  end

  def self.telegram_valid?(telegram)
    telegram.to_s.match?(/^@([a-zA-Z0-9_]{5,32})$/)
  end

  def self.email_valid?(email)
    email.to_s.match?(/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i)
  end

  def self.git_valid?(git)
    git.to_s.match?(/\Agithub\.com\/[\w-]+\z/)
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
