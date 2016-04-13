# Janken Game
CHOICES = %w(paper scissor rock)
man_choice = ''

# Prompts a default message
def prompt(message)
  puts "=> #{message}"
end

# Evaluate who won the match
def win?(first, second)
  first == 'rock' && second == 'scissor' ||
    first == 'paper' && second == 'rock' ||
    first == 'scissor' && second == 'paper'
end

# Displays the result of the match
def display_results(man, cpu)
  if win?(man, cpu)
    prompt("#{man} against #{cpu}. You won!")
  elsif win?(cpu, man)
    prompt("#{man} against #{cpu}. You lost!")
  else
    prompt("#{man} against #{cpu}. It's a tie!")
  end
end

# Check the result of the match
def overal_result(man, cpu)
  if win?(man, cpu)
    0
  elsif win?(cpu, man)
    1
  end
end

man_times = cpu_times = 0
loop do
  prompt('<<<<<<<<<<<<< JanKenPo >>>>>>>>>>>>>')

  loop do
    prompt('Choose your play(Rock/Paper/Scissor)')
    man_choice = gets.chomp.downcase
    CHOICES.include?(man_choice) ? break : prompt('Invalid choice!')
  end

  cpu_choice = CHOICES.sample
  if overal_result(man_choice, cpu_choice) == 0
    man_times += 1
  elsif overal_result(man_choice, cpu_choice) == 1
    cpu_times += 1
  end

  display_results(man_choice, cpu_choice)
  prompt('-------------- Score ---------------')
  prompt("Player: #{man_times} | CPU: #{cpu_times}")
  prompt('------------------------------------')

  if man_times == 5
    prompt('YOU WON THE BEST OF 5')
    man_times = cpu_times = 0
  end
  if cpu_times == 5
    prompt('CPU WON THE BEST OF 5')
    man_times = cpu_times = 0
  end

  prompt('Do you want to try again?(y/n)')
  exit = gets.chomp
  system 'clear'
  break unless exit.downcase.start_with?('y')
end
