note
	description: "rat_race application root class"
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
			player1, player2, player3, player4, player5, player6: PLAYER

		do
			--| Add your code here
			print ("========================== Welcome to the Rat Race ========================== %N%N%N")
			create game.make


			create player1.make ("Alice")
			create player2.make ("Bob")
			create player3.make ("Rose")
			create player4.make ("Alex")
			create player5.make ("Jason")
			create player6.make ("Peter")

			-- Test 1 --
			game.init_game

			game.add_player (player1)
			game.add_player (player2)

			game.play

			-- Test 2 --
			game.init_game

			game.add_player (player1)
			game.add_player (player2)
			game.add_player (player3)

			game.play

			-- Test 3 --
			game.init_game

			game.add_player (player1)
			game.add_player (player2)
			game.add_player (player3)
			game.add_player (player4)

			game.play

			-- Test 4 --
			game.init_game
			
			game.add_player (player1)
			game.add_player (player2)
			game.add_player (player3)
			game.add_player (player4)
			game.add_player (player5)
			game.add_player (player6)

			game.play
		end

feature

	game: BOARD_GAME
		-- An instance of a board game


end
