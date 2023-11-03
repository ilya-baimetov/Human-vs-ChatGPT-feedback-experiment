note
	description: "This class handles the logic for {PLAYER} in the game."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PLAYER

inherit
	HASHABLE

create
	make

feature -- Initialization

	make (a_name: like name)
			-- Instantiante a player with a given name and 15 hp
		require
			a_name_not_empty: not a_name.is_empty
		do
			hp_max := 15
			hp := hp_max
			name := a_name
			alive := True
		ensure
			hp_max_assigned: hp_max = 15
			hp_assigned: hp = hp_max
			name_assigned: name = a_name
			is_alive: alive
		end

feature -- Access

	name: STRING
			-- name of the player
		attribute
			Result := "Untitled"
		end

	alive: BOOLEAN
			-- is the player alive?

	hp: NATURAL
			-- health points of the player

feature {NONE} -- Access

	hash_code: INTEGER
		do
			Result := name.hash_code
		end

	hp_max: like hp
			-- maximum amout of health points a player can have

feature -- Element change

	fall_in_trap
			-- Decrease the hp of the player by 5, if the new value is smaller that 0, the player dies.
		require
			is_alive: alive
		do
			if hp >= 5 then
				hp := hp - 5
			else
				alive := False
			end
		ensure
			hp_reduction_by_five_or_dead:
				if alive then
					hp = old hp - 5
				else
					True
				end
		end

	heal
			-- Increase the hp of the player by 5, if the new value is bigger than 15, the hp is set to 15
		require
			is_alive: alive
		do
			if hp <= hp_max - 5 then
				hp := hp + 5
			else
				hp := hp_max
			end
		ensure
			hp_increase_by_five_or_maximum_hp:
				if old hp <= hp_max - 5 then
					hp = old hp + 5
				else
					hp = hp_max
				end
		end

invariant

	hp_within_bounds: hp <= hp_max

end
