require 'borisbikes'

describe DockingStation do


it 'releases bike from docking station' do
docking_station = DockingStation.new(1)
expect(docking_station).to respond_to(:release_bike)
end

it 'releases a working bike' do
  docking_station = DockingStation.new(5)
  docking_station.dock_bike(Bike.new)
  bike = docking_station.release_bike
  expect(bike.class).to eq(Bike)
  expect(bike.working?).to eq(true)
end

it 'takes a bike as arg, docks to instance var' do
  docking_station = DockingStation.new(5)
  bike = Bike.new
  docking_station.dock_bike(bike)
  expect(docking_station.list_of_bikes).to include(bike)
end

it 'does not release bikes when none are available' do
  docking_station = DockingStation.new(0)
  expect { raise docking_station.release_bike}.to raise_error
end

it 'does not dock bikes when no spaces are available' do
  docking_station = DockingStation.new(5)
  bike = Bike.new
  docking_station.capacity.times {docking_station.dock_bike(Bike.new)}
  expect { raise docking_station.dock_bike(bike)}.to raise_error
end

it 'returns twenty when not given capacity argument' do
  docking_station = DockingStation.new
  expect(docking_station.capacity).to eq(20)
end

it 'returns broken' do
  docking_station = DockingStation.new
  broken_bike = Bike.new('broken')
  docking_station.dock_bike(broken_bike)
  expect{ raise docking_station.release_bike}.to raise_error

end

end
