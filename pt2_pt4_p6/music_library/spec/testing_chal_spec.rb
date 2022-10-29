require_relative '../testing_chal'

RSpec.describe StringRepeater do
  it 'repeats a string' do 
    io = double :io

    expect(io).to receive(:puts).with('Hello. I will repeat a string many times.')
    expect(io).to receive(:puts).with('Please enter a string')
    expect(io).to receive(:gets).and_return('TWIX')
    expect(io).to receive(:puts).with('Please enter a number of repeats')    
    expect(io).to receive(:gets).and_return('3')
    expect(io).to receive(:puts).with('Here is your result')
    expect(io).to receive(:puts).with('TWIXTWIXTWIX')
    string_rep = StringRepeater.new(io)
    string_rep.run
  end 
end 