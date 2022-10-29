class Greeter
  def initialize(terminal)
    @terminal = terminal
  end  
  
  def greet
    @terminal.puts 'What is your name?'
    name = @terminal.gets.chomp
    @terminal.puts "Hello, #{name}!"
  end 
end 

