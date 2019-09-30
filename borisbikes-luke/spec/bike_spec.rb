require 'borisbikes'


describe Bike do

it 'checks if bike is working' do
  bike = Bike.new
  expect(bike).to respond_to(:working?)
end

it 'should return broken' do
  bike = Bike.new('broken')
  status = bike.broken
  expect(status).to eq('broken')
end

end
