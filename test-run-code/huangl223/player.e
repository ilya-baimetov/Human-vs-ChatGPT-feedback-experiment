note
	description: "Summary description for {PLAYER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PLAYER

create
	make

feature -- Initialization

	make (a_name: STRING)
		do
			name := a_name.twin
			point := 15
			position := 0
			set_is_alive (True)
		end

feature -- Status

	name: STRING
			-- Name of the player

	point: INTEGER
			-- Point of the player

	position: INTEGER
			-- Position of the player
			-- Value should be in [1, 50]

	is_alive: BOOLEAN
			-- Is the player still in the game?

	Heal_point: INTEGER = 5

	Kill_point: INTEGER = 5

feature -- Operation

	play (d1: DICE; d2: DICE)
			-- Roll the two dices and move towards on board based on the result
		do
			d1.roll_dice
			d2.roll_dice

			position := (position + d1.point + d2.point)

			if is_at_healing_square and point <= 10 then
				point := point + Heal_point
			elseif is_at_trap then
				point := point - Kill_point
			end

			if point < 0 then
				set_is_alive (False)
			end
		end

	is_at_healing_square: BOOLEAN
			-- Is the player at healing squares: 5, 15, 25, 35, 45
		do
			Result := (position \\ 10 = 5)
		end

	is_at_trap: BOOLEAN
			-- Is the player at trap: 10, 20, 30, 40, 50
		do
			Result := (position \\ 10 = 0)
		end

	has_reached_end_square: BOOLEAN
		do
			Result := position >= 50
		end

	set_is_alive (a_is_alive: BOOLEAN)
		do
			is_alive := a_is_alive
		end

end
