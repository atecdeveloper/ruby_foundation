# Calculator program
operation = ''
run_calc = 'n'

# Performs the requested calculation
def calculate(op, x, y)
  case op
  when 'plus'
    x + y
  when 'minus'
    x - y
  when 'divide'
    x / y
  when 'multiple'
    x * y
  end
end

while run_calc != "y"
  puts "---------- Calc v3.0 ----------"
  puts "Choose first number"
  num1 = gets.to_f
  puts "Choose second number"
  num2 = gets.to_f
  puts "Choose operation (plus/minus/divide/multiple)"
  operation = gets.chomp.downcase

  while operation != "plus" && operation != "minus" && operation != "divide" && 
    operation != "multiple"
    puts "Operation invalid"
    puts "Choose operation (plus/minus/divide/multiple)"
    operation = gets.chomp.downcase
  end

  puts "-------------------------------"
  puts "#{num1} #{operation} #{num2} = #{calculate(operation, num1, num2)}"
  puts "-------------------------------"
  puts "Do you want to exit? (y/n)"
  run_calc = gets.chomp.downcase
end
