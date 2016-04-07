# Calculator program
require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

operation = ''
run_calc = 'n'
num1 = ''
num2 = ''
message = ''
LANGUAGE = 'en'
#LANGUAGE = 'pt-br'

# Choosing message/language from yml file
def messages(message, lang='en')
  MESSAGES[lang][message]
end

# Prompts a default message
def prompt(key)
  message = messages(key, LANGUAGE)
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

# Shows result
def show_result(num1, num2, operation)
  puts "=> #{num1} #{operation} #{num2} = #{calculate(operation, num1, num2)}"
end

while run_calc != "y"
  prompt('header')
  loop do
    prompt('opt1')
    num1 = gets.chomp
    valid_number?(num1) ? break : prompt('opterror')
  end

  loop do
    prompt('opt2')
    num2 = gets.chomp
    valid_number?(num2) ? break : prompt('opterror')
  end

  # Block of message to output on prompt
  operator_prompt = <<-MSG
=>   What operation would you like to perform
    .Plus
    .Minus
    .Divide
    .Multiple
  MSG

  puts operator_prompt

  loop do
    operation = gets.chomp.downcase
    %w(plus minus divide multiple).include?(operation) ? break : prompt('oper')
  end

  prompt('dash')
  show_result(num1, num2, operation)
  prompt('dash')
  prompt('exit')
  run_calc = gets.chomp.downcase
end
