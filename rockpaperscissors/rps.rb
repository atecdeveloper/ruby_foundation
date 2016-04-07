# Janken Game
CHOICES = %w(paper scissor rock)
man_choice = ''
cpu_choice = CHOICES.sample

# Prompts a default message
def prompt(message)
  puts "=> #{message}"
end

# Checks who won the match
def win?(first, second)
  first == 'rock' && second == 'scissor' ||
    first == 'paper' && second == 'rock' ||
    first == 'scissor' && second == 'paper'
end

# Method that displays the result of the match
def display_results(man, cpu)
  if win?(man, cpu)
    prompt("#{man} against #{cpu}. You won!")
  elsif win?(cpu, man)
    prompt("#{man} against #{cpu}. You lost!")
  else
    prompt("#{man} against #{cpu}. It's a tie!")
  end
end

loop do
  system 'clear'
  prompt('------------- JanKenPo -------------')
  loop do
    prompt('Choose your play(Rock/Paper/Scissor)')
    man_choice = gets.chomp.downcase
    CHOICES.include?(man_choice) ? break : prompt('Invalid choice!')
  end

  display_results(man_choice, cpu_choice)
  prompt('------------------------------------')
  prompt('Do you want to try again?(y/n)')
  exit = gets.chomp
  break unless exit.downcase.start_with?('y')
end
