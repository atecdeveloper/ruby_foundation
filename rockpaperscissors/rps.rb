# Janken Game
CHOICES = %w(paper scissor rock)
man_choice = ''
cpu_choice = CHOICES.sample

# Prompts a default message
def prompt(message)
  puts "=> #{message}"
end

# Method that compares player x cpu play
def display_results(man, cpu)
  if man == 'rock' && cpu == 'paper' ||
      man == 'paper' && cpu == 'scissor' ||
      man == 'scissor' && cpu == 'rock'
    prompt("#{man} against #{cpu}. You lost!")
  elsif man == 'rock' && cpu == 'scissor' ||
      man == 'scissor' && cpu == 'paper' ||
      man == 'paper' && cpu == 'rock'
    prompt("#{man} against #{cpu}. You won!")
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
