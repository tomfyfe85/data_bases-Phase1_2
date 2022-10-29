require_relative '../wrapping_app'

RSpec.describe Greeter do
  it 'asks the user their name and says hello' do 
   terminal = double :terminal
   expect(terminal).to receive(:puts).with("What is your name?")
   expect(terminal).to receive(:gets).and_return("Tom")
   expect(terminal).to receive(:puts).with("Hello, Tom!")
   greeter = Greeter.new(terminal)
   greeter.greet
  end 
end 