note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	NEW_TEST_SET

inherit
	EQA_TEST_SET

feature -- Test routines

	new_test_routine
			-- New test routine
		local
			player: PLAYER
		do
			create player.make ("Albert")
			player.fall_in_trap
			player.fall_in_trap
			player.fall_in_trap
			assert("alive when hp = 0", player.hp = 0 and player.alive)
			player.fall_in_trap
			assert("dead when hp < 0", not player.alive)
		end

end


