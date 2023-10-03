note
	description: "project application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS_32

create
	make

feature {NONE} -- Initialization

	Players_count: INTEGER = 6

	make
			-- Run application.
		local
			g: GAME
			i: INTEGER
		do
			create g.make (Players_count)
			g.play_game
			from
				i := 1
			until
				i > Players_count
			loop
				print (g.players [i].name + ": " + g.positions [i].out + "%N")
				i := i + 1
			end
		end

end
