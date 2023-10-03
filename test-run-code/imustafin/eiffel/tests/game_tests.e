note
	description: "[
			Eiffel tests that can be executed by testing tool.
		]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	GAME_TESTS

inherit
	EQA_TEST_SET

feature -- Test routines

	test_game_ends_after_last_cell
			-- Game ends after any player reaches cell beyond 50
		local
			g: GAME
		do
			create g.make (2)
			g.positions [1] := 51
			assert ("game finished after reaching > 50 cell", g.is_finished)
		end

	test_last_round_everyone_moves
			-- Game ends after the last round, so all players should have moved
		local
			g: GAME
		do
			create g.make (2)
			g.positions [1] := 50
			g.play_game
			assert ("all players moved", g.positions [1] > 50 and g.positions [2] > 1)
		end

	test_eliminitaed_players_do_not_move
			-- Eliminted players do not play anymore
		local
			g: GAME
		do
			create g.make (2)
			g.players [1].damage (g.players [1].hp + 1)
			g.play_round
			assert ("eliminated player does not move", g.positions [1] = 1)
			assert ("not eliminiated player moved", g.positions [2] > 1)
		end

	test_zero_hp_is_not_eliminated
			-- 0 hp is not eliminated yet
		local
			g: GAME
		do
			create g.make (2)
			g.players [1].damage (g.players [1].hp)
			g.play_round
			assert ("zero hp moves", g.positions [1] > 1)
		end

	test_trap_locations
		local
			g: GAME
		do
			create g.make (2)
			across
				<<10, 20, 30, 40, 50>> is i
			loop
				assert ("trap cell at " + i.out, g.cell_action_at (i) = g.damage_cell_action)
			end
			assert ("not trap cell at 1", g.cell_action_at (1) /= g.damage_cell_action)
		end

	test_heal_locations
		local
			g: GAME
		do
			create g.make (2)
			across
				<<5, 15, 25, 35, 5>> is i
			loop
				assert ("heal cell at " + i.out, g.cell_action_at (i) = g.heal_cell_action)
			end
			assert ("not heal cell at 1", g.cell_action_at (1) /= g.heal_cell_action)
		end

end

