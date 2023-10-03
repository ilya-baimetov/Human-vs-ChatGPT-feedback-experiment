note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	PLAYER_TESTS

inherit
	EQA_TEST_SET

feature -- Test routines

	player_heal_beyond_max
		local
			p: PLAYER
		do
			create p.make (5, 10, "")
			p.heal (15)
			assert ("can't heal above max hp", p.hp = 10)
		end

end


