class StringRepeater 
  def initialize(io)
    @io = io
  end 

  def run
    @io.puts 'Hello. I will repeat a string many times.'
    @io.puts 'Please enter a string'
    str = @io.gets.chomp
    @io.puts 'Please enter a number of repeats'
    str2 = @io.gets.chomp
    @io.puts 'Here is your result'
    @io.puts "#{str * str2.to_i}"
  end 
end 