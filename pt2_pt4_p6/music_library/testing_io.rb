class InteractiveCalculator
  def initialize(terminal)
    @terminal = terminal
  end 

  def subtract
    @terminal.puts 'Hello. I will subtract two numbers.'
    @terminal.puts 'Please enter a number'
    num1 = @terminal.gets.chomp 
    @terminal.puts 'Please enter another number'
    num2 = @terminal.gets.chomp
    @terminal.puts 'Here is your result'
    @terminal.puts "#{num1.to_i} - #{num2.to_i} = #{num1.to_i - num2.to_i}"
  end 

end 