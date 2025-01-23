class Delivery_strategy
  def calculate_cost(weight)
    raise NotImplementedError, "Метод должен быть реализован в подклассе"
  end
end

class Courier_delivery < Delivery_strategy
  def calculate_cost(weight)
    5 + weight * 0.5 # Базовая цена + цена за вес
  end
end

class Postal_delivery < Delivery_strategy
  def calculate_cost(weight)
    3 + weight * 0.3 # Другая формула расчета
  end
end

class Pickup_delivery < Delivery_strategy
  def calculate_cost(weight)
    0 # Самовывоз бесплатный
  end
end

class Delivery_cost_calculator
  attr_accessor :strategy

  def initialize(strategy)
    @strategy = strategy
  end

  def calculate(weight)
    @strategy.calculate_cost(weight)
  end
end

courier = Courier_delivery.new
postal = Postal_delivery.new
pickup = Pickup_delivery.new

calculator = Delivery_cost_calculator.new(courier)
puts "Курьерская доставка: #{calculator.calculate(10)}"

calculator.strategy = postal
puts "Доставка почтой: #{calculator.calculate(10)}"

calculator.strategy = pickup
puts "Самовывоз: #{calculator.calculate(10)}"
