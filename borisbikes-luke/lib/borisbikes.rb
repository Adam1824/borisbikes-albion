class DockingStation
  attr_reader :bikes, :capacity

  DEFAULT_CAPACITY = 20

  def initialize(capacity=DEFAULT_CAPACITY)
    @bikes = []
    @capacity = capacity
  end

  def release_bike
    if !(bikes.empty?) || status == 'working'
      bikes.slice(0)
      bikes.delete_at(0)
    else
      fail
    end
  end

  def dock_bike(bike, status='working')
    if status != 'working'
      bike.broken
    end
    if full?
      fail
    else
      bikes << bike
    end
  end

  def list_of_bikes()
    bikes
  end

  private

  def full?
    bikes.count >= capacity
  end

end

class Bike
  attr_accessor :status

  def initialize(status='working')
    @status = status
  end

  def working?
    status == 'working'
  end

  def broken
    status = 'broken'
  end
end

class Van
  attr_accessor :storage_v
  def initialize
    @storage_v = []
  end

  def get_bikes_from_dock(docking_station)
    docking_station.bikes.each do |bike|
      if bike.status == 'broken'
        storage_v << bike
      end
    end
  end

  def get_bikes_from_garage(storage_g)
    storage_v = storage_g
  end

  def dock_bikes_from_van(docking_station)
    storage_v.each do |bike|
      docking_station.dock_bike(bike)
    end
  end

end

class Garage
  attr_accessor :storage_g
  def initialize
    @storage_g = []
  end

  def fix(bikes)
    bikes.each do |bike|
      bike.status = 'working'
      storage_g << bike
    end
  end
end

# docking_station = DockingStation.new
# bike = docking_station.release_bike
# docking_station.release_bike
# p docking_station.list_of_bikes
# p bike
# docking_station.dock_bike(bike)
# p docking_station.list_of_bikes
# 20.times {docking_station.dock_bike(Bike.new)}
# puts docking_station.list_of_bikes
# docking_station.dock_bike(Bike.new)
# docking_station.full?
