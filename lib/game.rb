require_relative 'player'
require_relative 'board'
require_relative 'cell'
require_relative 'coordinates'
require_relative 'ship'
require_relative 'water'

class Game
	def initialize
		@players = []
	end

	attr_reader :players

	def add(player)
		@players << player
	end

	def start?
		@players.count == 2
	end

	def return_opponent(me)
		@players.reject { |player| player.name == me }.first
	end

	def return_player(me)
		@players.select { |player| player.name == me }.first
	end

	def has_ships_floating?(player)
		player.board.grid.values.any?{|cell| cell.status == 'S'}
	end
end