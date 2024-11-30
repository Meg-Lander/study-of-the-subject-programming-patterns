class Person

  attr_reader :id, :git, :phone, :telegram, :email

  def initialize(params)
    @id = params[:id]
    @git = params[:git]
    @phone = params[:phone]
    @telegram = params[:telegram]
    @email = params[:email]
    
    validate
  end

  private_class_method :git_present?
  private_class_method :has_contact_info?


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

  # Проверка на наличие хотя бы одного контакта
  def has_contact_info?
    !@phone.nil? && !@phone.strip.empty? || 
    !@telegram.nil? && !@telegram.strip.empty? || 
    !@email.nil? && !@email.strip.empty?
  end



  def set_contacts(contacts = {})
    if contacts.key?(:phone)
      @phone = validate_phone(contacts[:phone])
    end

    if contacts.key?(:telegram)
      @telegram = validate_telegram(contacts[:telegram])
    end

    if contacts.key?(:email)
      @email = validate_email(contacts[:email])
    end
  end

  def validate
    raise ArgumentError, 'Не указан GitHub!' unless git_present?
    raise ArgumentError, 'Отсутствует любой контакт для связи!' unless has_contact_info?
    raise ArgumentError, "Некорректный id: #{@id}" if @id && !Person.id_valid?(@id)
    raise ArgumentError, "Некорректный телефонный номер: #{@phone}" if @phone && !Person.phone_valid?(@phone)
    raise ArgumentError, "Некорректный Telegram: #{@telegram}" if @telegram && !Person.telegram_valid?(@telegram)
    raise ArgumentError, "Некорректный Email: #{@email}" if @email && !Person.email_valid?(@email)
    raise ArgumentError, "Некорректный GitHub: #{@git}" if @git && !Person.git_valid?(@git)
  end
  

  def git_info
    @git.nil? || @git.strip.empty? ? 'Нет GitHub' : @git
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
      'Нет контактной информации'
    end
  end


end