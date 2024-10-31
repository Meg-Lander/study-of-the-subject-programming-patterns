def is_prime(num)
  if num <= 1
    return false
  (2..Math.sqrt(num)).each do |i|
    if num % i == 0
      return false 
  end
  true
end

def max_prime_divisor(num)
  max_pr = -1
  (2..(num)).each do |i|
    if num % i == 0 && is_prime(i)
      max_pr = i
    end
  end
  max_pr
end

puts "Введите число: "
num = gets.to_i
result = max_prime_divisor(num)
puts "Максимальный простой делитель числа #{num} — это #{result}" if result != -1
