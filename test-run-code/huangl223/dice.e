note
	description: "Summary description for {DICE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DICE

inherit
	RANDOM

feature

	point: INTEGER
		-- Point of the face-up side of the dice

	roll_dice
		-- Roll the dice
		do
			point := randomizer.item \\ 6 + 1
			randomizer.forth
		end

feature {NONE}

	randomizer: RANDOM
			-- Pseudo-random generator initialized only once
		once
			create Result.set_seed (123)
			Result.start
		end

end
