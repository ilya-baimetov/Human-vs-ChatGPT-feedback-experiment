note
	description: "[
			Eiffel tests that can be executed by testing tool.
		]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	NEW_TEST_SET_002

inherit
	EQA_TEST_SET

feature -- Test routines

	new_test_routine
			-- New test routine
		local
			game: GAME
			player: PLAYER
		do
			create game.make
			player := game.players.item (1)
			player.fall_in_trap
			assert ("hp after fall", player.hp = 10)
		end

end

