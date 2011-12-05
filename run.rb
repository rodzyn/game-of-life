require './gameoflife'

def clear
	system("clear")
end

world = World.new
world.add_cell(0, 0)
world.add_cell(0, 1)
world.add_cell(0, -1)

loop do
	sleep 1
	clear
	world.tick!
	(-20..20).each do |x|
		(-40..40).each do |y|
			if world.cell_exists?(x, y)
				print " o"
			else
				print " ."
			end
		end
		print "\n"
	end
end
