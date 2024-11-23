def is_prime(num)
  return false if num < 2
  (2..Math.sqrt(num)).each do |i|
    return false if num % i == 0
  end
  true
end

def max_odd_no_prime_divisor(num)
  max_divisor = nil
  (1..num).each do |i|
    if num % i == 0 && i.odd? && !is_prime(i)
      max_divisor = i
    end
  end
  max_divisor
end

def product_of_digits(num)
  prod = 1
  while num > 0
    digit = num % 10
    num = num / 10
    prod *= digit
  end
  prod
end

def method_evklid(a, b)
  b == 0 ? a : method_evklid(b, a % b)
end

def find_NOD_for_product_divisor(num)
  max_no_prime = max_odd_no_prime_divisor(num)
  prod_of_dig = product_of_digits(num)
  
  if max_no_prime.nil?
    puts "Не найден нечётный непростой делитель"
    return false
  end
  
  if prod_of_dig > max_no_prime
    met_evklid = method_evklid(prod_of_dig, max_no_prime)
  else
    met_evklid = method_evklid(max_no_prime, prod_of_dig)
  end
  
  met_evklid
end

puts "Введите число:"
num = gets.to_i
result = find_NOD_for_product_divisor(num)

if result == false
else
  puts "НОД между максимальным нечётным непростым делителем и произведением цифр числа: #{result}"
end
