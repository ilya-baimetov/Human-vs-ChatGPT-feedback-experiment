note
	description: "This class handles the {DIE}, to produce a random integer value between 1 and 6."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DIE

create
	make

feature -- Initialization

	make
			-- Initialization for a 6-faced die.
			-- The random sequence is instantiated with a fixed default seed.
		do
			create random_sequence.make
			last_roll := 0
		ensure
			last_roll_init: last_roll = 0
		end

feature {NONE} -- Access

	random_sequence: RANDOM
			-- random sequence to introduce the randomness for the die roll
feature -- Access

	last_roll: INTEGER
			-- Result of last roll
feature -- Element change

	roll
			-- Roll a d6-die, a die with 6 faces.
		do
			random_sequence.forth
			last_roll := random_sequence.item.abs \\ 6 + 1
		ensure
			roll_valid_d6: last_roll > 0 and last_roll <= 6
		end

end
