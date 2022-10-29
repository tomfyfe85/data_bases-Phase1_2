require_relative '../testing_io'

RSpec.describe InteractiveCalculator do
 it 'subtracts two numbers' do 
    terminal = double :terminal 
    
    expect(terminal).to receive(:puts).with('Hello. I will subtract two numbers.') 
    expect(terminal).to receive(:puts).with('Please enter a number')
    expect(terminal).to receive(:gets).and_return('4')
    expect(terminal).to receive(:puts).with('Please enter another number')
    expect(terminal).to receive(:gets).and_return('3')
    expect(terminal).to receive(:puts).with('Here is your result')
    expect(terminal).to receive(:puts).with('4 - 3 = 1')
  inter = InteractiveCalculator.new(terminal)
  inter.subtract
  end 
end 
