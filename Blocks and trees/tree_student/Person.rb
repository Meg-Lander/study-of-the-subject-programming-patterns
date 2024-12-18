class Person

  attr_reader :git, :phone, :telegram, :email

   def initialize(params)
    self.id = params[:id] if params[:id]
    self.git = params[:git] if params[:git]
    self.phone = params[:phone] if params[:phone]
    self.telegram = params[:telegram] if params[:telegram]
    self.email = params[:email] if params[:email]
  end

  def id=(value)
    raise ArgumentError, 'Некорректный ID' unless self.class.id_valid?(value)
    @id = value
  end


  def git=(value)
    raise ArgumentError, 'Некорректный GitHub' unless self.class.git_valid?(value)
    @git = value
  end

  # Проверки регулярками
  def self.id_valid?(id)
    id.to_s.match?(/^([0-9])$/)
  end

  def self.git_valid?(git)
    git.to_s.match?(/\Agithub\.com\/[\w-]+\z/)
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


  # Проверка на наличие гита
  def git_present?
    !@git.nil? && !@git.strip.empty?
  end
  

  def set_contacts(contacts = {})
    if contacts.key?(:phone)
      self.phone = contacts[:phone]
    end

    if contacts.key?(:telegram)
      self.telegram = contacts[:telegram]
    end

    if contacts.key?(:email)
      self.email = contacts[:email]
    end
  end



  # Методы для отображения информации
  def contact_info
    if !@phone.nil? && !@phone.strip.empty?
      "Телефон: #{@phone}"
    elsif !@telegram.nil? && !@telegram.strip.empty?
      "Телеграм: #{@telegram}"
    elsif !@email.nil? && !@email.strip.empty?
      "Почта: #{@email}"
    else
      nil
    end
  end
  
  private
  def phone=(value)
    raise ArgumentError, 'Некорректный номер телефона' unless self.class.phone_valid?(value)
    @phone = value
  end

  def telegram=(value)
    raise ArgumentError, 'Некорректный Telegram' unless self.class.telegram_valid?(value)
    @telegram = value
  end

  def email=(value)
    raise ArgumentError, 'Некорректный email' unless self.class.email_valid?(value)
    @email = value
  end

end
