class Ship

	attr_accessor :size
	attr_accessor :points
	attr_accessor :ship
	attr_accessor :name
	
	ATTRIBUTES = {
		aircraft_carrier: [5, 20],
		battleship: [4, 12],
		submarine: [3, 6],
		destroyer: [3, 6],
		cruiser: [3, 6],
		patrol_boat: [2, 2]
	}

	def initialize(name)
		initialize_ship
		self.name = name
	end

	def initialize_ship(name)
		size, points = ATTRIBUTES[name]
		self.size = size
		self.points = points
	end

end
