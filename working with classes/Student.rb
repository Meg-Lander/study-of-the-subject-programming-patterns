class Student
  attr_accessor :id, :surname, :name, :middle_name, :phone, :telegram, :email, :git

  def initialize(surname, name, middle_name, id = nil, phone = nil, telegram = nil, email = nil, git = nil)
    @surname = surname
    @name = name
    @middle_name = middle_name
    @id = id
    @phone = phone
    @telegram = telegram
    @email = email
    @git = git
  end
end
