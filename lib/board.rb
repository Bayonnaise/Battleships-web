require './lib/cell'

class Board

	def initialize(content: :water)
		@grid = create_new_grid_with(content)
	end

	def grid
		@grid
	end

	def place(ship_type, at_coordinates)
		at_coordinates.locations.each do |location|
			grid[location].content = ship_type
		end
	end

	def get_horizontal_coords(ship_type, start_cell)
		coords = [start_cell]
		chars = start_cell.chars
		row = chars.shift
		col = chars.join
		(ship_type.remaining_hits - 1).times do
			col = ((col.to_i) + 1).to_s
			coords << "#{row}#{col}"
		end
		coords
	end

	def get_vertical_coords(ship_type, start_cell)
		coords = [start_cell]
		chars = start_cell.chars
		row = chars.shift
		col = chars.join
		(ship_type.remaining_hits - 1).times do
			row = row.next
			coords << "#{row}#{col}"
		end
		coords
	end

	def render_display

		rows_of_cells.each_slice(10).map { |el| el }
	end

	def nice_display
		render_display.each{|row| p row}
	end

	def render_display_without_ships
		temp = grid.values.map do |cell|
			cell.status == 'S' ? '~' : cell.status
		end
		temp.each_slice(10).map { |el| el }
	end

	private

	def rows_of_cells
		grid.values.map{|cell| cell.status}
	end
	
	def create_new_grid_with(content)
		("A".."J").map { |letter| (1..10).map { |number| {"#{letter}#{number}" => Cell.new(content) } } }.flatten.inject(&:merge)
	end



end