def is_prime(num)
  return false if num <= 1
  (2..Math.sqrt(num)).each do |i|
    return false if num % i == 0
  end
  true
end

def max_prime_divisor(n)
  max_pr = -1
  (2..(n)).each do |i|
    if n % i == 0 && is_prime(i)
      max_pr = i
    end
  end
  max_pr
end

puts "Введите число: "
n = gets.to_i
result = max_prime_divisor(n)
puts "Максимальный простой делитель числа #{n} — это #{result}" if result != -1
