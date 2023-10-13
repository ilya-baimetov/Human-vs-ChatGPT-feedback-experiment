note
	description: "Rat race application root class."
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS_32

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			game: GAME
		do
			create game.make
			game.run
		end

end
