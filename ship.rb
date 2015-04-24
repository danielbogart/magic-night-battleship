class Ship

	attr_accessor :size
	attr_accessor :points
	attr_accessor :ship
	attr_accessor :name, :single_char

	ATTRIBUTES = {
		aircraft_carrier: [5, 20, 'a'],
		battleship: [4, 12, 'b'],
		submarine: [3, 6, 's'],
		destroyer: [3, 6, 'd'],
		cruiser: [3, 6, 'c'],
		patrol_boat: [2, 2, 'p']
	}

	def to_s
		single_char
	end

	def initialize(name)
		initialize_ship(name)
		self.name = name
	end

	def initialize_ship(name)
		size, points, c = ATTRIBUTES[name]

		self.size = size
		self.points = points
		self.single_char = c
	end
end
