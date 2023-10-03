class
	DICE

create
	make

feature
	make (a_dice: INTEGER)
		do
			dice := a_dice
			create random.make
		end

feature
	last_roll: INTEGER

	random: RANDOM

	dice: INTEGER

	roll
		local
			i: INTEGER
		do
			from
				i := 1
				last_roll := 0
			until
				i > dice
			loop
				random.forth
				last_roll := last_roll + (random.item \\ 5) + 1
				i := i + 1
			end
		end

invariant
	1 <= dice

end
