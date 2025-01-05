require_relative 'Person'

class Student < Person
  attr_reader :phone, :telegram, :email

  def initialize(params)
    super(params)
    set_contacts(params)
  end

  
  def get_initials_contact
    "#{initials_name}; GitHub: #{@git}; Связь: #{get_contact}"
  end

  def get_contact 
    "#{phone || telegram || email}"
  end

  def contact_present?
    [@phone, @telegram, @email].any? { |contact| contact && !contact.strip.empty? }
  end

  def contact_and_git_present?
    git_present? || contact_present?
  end

  def to_s
    "#{@id} #{@surname} #{@name} #{@middle_name}\nGit: #{@git}\nДанные для связи:\nНомер телефона: #{@phone}\nТелеграм: #{@telegram}\nEmail: #{@email}\n\n"
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

  def self.phone_valid?(phone)
    phone.to_s.match?(/^(\d{11}|\+\d{11})$/)
  end

  def self.telegram_valid?(telegram)
    telegram.to_s.match?(/^@([a-zA-Z0-9_]{5,32})$/)
  end

  def self.email_valid?(email)
    email.to_s.match?(/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i)
  end

  def surname=(names)
    super(names)
  end

  def middle_name=(names)
    super(names)
  end

  def name=(names)
    super(names)
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
