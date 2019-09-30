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
  # docking_station = DockingStation.new(5)
  # bike = Bike.new
  # docking_station.capacity.times {docking_station.dock_bike(Bike.new)}
  # expect { raise docking_station.dock_bike(bike)}.to raise_error
  bike = double(:bike, broken: 'working')
  subject.capacity.times { subject.dock_bike(bike)}
  expect { subject.dock_bike(bike) }.to raise_error
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

describe Van do

  it 'can get broken bike' do
    bike = double(:bike, broken: 'broken')
    expect(subject).to respond_to(:get_bikes_from_dock)
  end

  it 'can dock a bike' do
    docking_station = DockingStation.new
    subject.storage_v = ['1','2','3']
    subject.dock_bikes_from_van(docking_station)
    expect(docking_station.bikes).to eq(subject.storage_v)

  end

  it 'can get the fixed bikes from the garage' do
    garage = double(storage_g: ['1','2','3'])
    expect(subject.get_bikes_from_garage(garage.storage_g)).to eq(garage.storage_g)
  end
end

describe Garage do

  it 'can fix bikes' do
    bike = Bike.new('broken')
    docking_station = DockingStation.new
    docking_station.dock_bike(bike)
    van = Van.new
    van.get_bikes_from_dock(docking_station)
    subject.fix(van.storage_v)
    expect(subject.storage_g).to include(bike)
    expect(bike.status).to eq('working')
  end

end
