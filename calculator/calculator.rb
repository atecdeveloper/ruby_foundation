# Calculator program


operation = ''
run_calc = 'n'
num1 = ''
num2 = ''

# Prompts a default message
def prompt(message)
  puts "=> #{message}"
end

# Checks if the number is really a cardinal
def valid_number?(num)
  num =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/
end

# Performs the requested calculation
def calculate(op, x, y)
  case op
  when 'plus'
    x.to_f + y.to_f
  when 'minus'
    x.to_f - y.to_f
  when 'divide'
    x.to_f / y.to_f
  when 'multiple'
    x.to_f * y.to_f
  end
end

while run_calc != "y"
  prompt("---------- Calc v3.0 ----------")
  loop do
    prompt("Choose first number")
    num1 = gets.chomp
    valid_number?(num1) ? break : prompt("Thats not a valid number!")
  end

  loop do
    prompt("Choose second number")
    num2 = gets.chomp
    valid_number?(num2) ? break : prompt("Thats not a valid number!")
  end

  # Block of message to output on prompt
  operator_prompt = <<-MSG
    What operator would you like to perform
    .Plus
    .Minus
    .Divide
    .Multiple
  MSG

  prompt(operator_prompt)

  loop do
    ope_msg = "Must choose (plus/minus/divide/multiple)"
    operation = gets.chomp.downcase
    %w(plus minus divide multiple).include?(operation) ? break : prompt(ope_msg)
  end

  prompt("-------------------------------")
  prompt("#{num1} #{operation} #{num2} = #{calculate(operation, num1, num2)}")
  prompt("-------------------------------")
  prompt("Do you want to exit? (y/n)")
  run_calc = gets.chomp.downcase
end
