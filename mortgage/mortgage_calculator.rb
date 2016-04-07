# Mortgage Calculator
answer = 'y'
loan_amount = ''
apr = ''
loan_duration = ''

# Prompts a default message
def prompt(message)
  puts "=> #{message}"
end

# Checks if the string is a positive number
def valid_number?(num)
  num =~ /\A[+]?[0-9]*\.?[0-9]+\Z/
end

# Calculates the monthly payment
def monthly_payment(amount, rate, years)
  annual_apr = rate.to_f / 100
  monthly_apr = annual_apr / 12
  months = years.to_i * 12
  monthly_payment = amount.to_f * (monthly_apr /
                    (1 - (1 + monthly_apr)**-months.to_i))
  monthly_payment
end

# def duration_isvalid?(months)
#  valid_number?(months) ? (1..12).include?(months.to_i) : false
# end

prompt('----------Mortgage Calculator----------')
while answer == 'y'
  loop do
    prompt('Loan Amount:')
    loan_amount = gets.chomp
    valid_number?(loan_amount) ? break : prompt('Must be a positive number!')
  end

  loop do
    prompt('Interest rate:')
    prompt('Example: 5 for 5% ir 2.5 for 2.5%')
    apr = gets.chomp
    valid_number?(apr) ? break : prompt('Must be a positive number!')
  end

  loop do
    prompt('Loan Duration(years):')
    loan_duration = gets.chomp
    if valid_number?(loan_duration) && loan_duration.to_i.to_s == loan_duration
      break
    else
      prompt('Must be in years!')
    end
  end

  payment = monthly_payment(loan_amount, apr, loan_duration)
  prompt("Your monthly payment is: $#{format('%02.2f', payment)}")
  prompt('Do you want to the calc again?(y/n)')
  answer = gets.chomp.downcase
  system('clear')
end
