class Logger
  @instance = new

  def self.instance
    @instance
  end

  private_class_method :new

  def log(message)
    puts "LOG: #{message}"
  end
end

logger1 = Logger.instance
logger2 = Logger.instance

puts "logger1 и logger2 являются одним и тем же объектом: #{logger1.equal?(logger2)}"

logger1.log("Это первое сообщение лога.")
logger2.log("Это второе сообщение лога.")

begin
  logger3 = Logger.new
rescue NoMethodError => e
  puts "Ошибка: #{e.message}"
end


