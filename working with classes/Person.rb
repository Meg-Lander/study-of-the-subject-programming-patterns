class Person

  attr_reader :git, :surname, :name, :middle_name, :id

   def initialize(params)
    self.id = params[:id] if params[:id]
    self.surname = params[:surname]
    self.name = params[:name]
    self.middle_name = params[:middle_name]
    self.git = params[:git] if params[:git]
    
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
    id.to_s.match?(/^\d+$/)
  end

  def self.git_valid?(git)
    git.to_s.match?(/\Agithub\.com\/[\w-]+\z/)
  end

  def self.name_valid?(name)
    name.to_s.match?(/\A[А-ЯA-Z][а-яa-z]{1,}\z/)
  end

  # Проверка на наличие гита
  def git_present?
    !@git.nil? && !@git.strip.empty?
  end

  def contact 
    raise NotImplementedError, 'Метод contact должен быть реализован в подклассе'
  end
  
  def contact_present?
    raise NotImplementedError, 'Метод contact_present? должен быть реализован в подклассе'
  end

  def contact_and_git_present?
    raise NotImplementedError, 'Метод contact_and_git_present? должен быть реализован в подклассе'
  end

  def initials_name
    "#{@surname} #{@name}.#{@middle_name}."
  end

  
  private
  
  def surname=(names)
    raise ArgumentError, 'Некорректный ID' unless self.class.name_valid?(names)
    @surname = names
  end

  def middle_name=(names)
    raise ArgumentError, 'Некорректный ID' unless self.class.name_valid?(names)
    @middle_name = names
  end

  def name=(names)
    raise ArgumentError, 'Некорректный ID' unless self.class.name_valid?(names)
    @name = names
  end
end
