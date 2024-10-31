def product_of_digits_no_5(num)
  prod = 1
  
  while num > 0
    digit = num % 10
    num = num / 10

    if digit % 5 != 0
      prod *= digit
    end
  end

  prod
end

puts "Введите число:"
num = gets.to_i
result = product_of_digits_no_5(num)
puts "Произведение цифр числа, не делящихся на 5: #{result}"
