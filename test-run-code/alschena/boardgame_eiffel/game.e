note
	description: "This {GAME} class handles the game logic."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GAME

create
	make

feature -- Initialization

	make
			-- Initialize the game
		do
			init_players
			init_board
			init_dice
		end

feature {NONE} -- Initialization

	init_players
			-- Initialize the player feature, there must be between 2 and 6 players
		local
			num_players: INTEGER
			player: PLAYER
		do
			num_players := 2

			create players.make_empty
			across 1 |..| num_players as index_players
			loop
				create player.make ("PLAYER" + index_players.item.out)
				players.force (player, index_players.item)
			end

		ensure
			players_between_2_and_6: players.count >= 2 and players.count < 6
		end

	init_board
			-- Initialize the board, which exposes the players placement
		require
			valid_players: players.count >= 2 and players.count <= 6
		do
			create board.make (players)
		end

	init_dice
			-- Instantiate 2 dice, as separated entities.

		local
			num_dice: INTEGER
			die: DIE
		do
			num_dice := 2

			create dice.make_empty
			across 1 |..| num_dice as index
			loop
				create die.make
				dice.force (die, index.item)
			end
		ensure
			two_dice: dice.count = 2
		end

feature -- Access

	last_roll: INTEGER
			-- Stores the sum of the roll of each die

	players: ARRAY [PLAYER]
			-- Array of players

	board: BOARD
			-- Board that stores an array of squares and the placement of the players

	dice: ARRAY [DIE]
			-- Array of dice

feature -- Status report

	display_players_in_game
			-- Display the information of all the player and their placement on the board
		require
			players_not_empty: not players.is_empty
		do
			across players as player loop
				print (player.item.name)
				print ("%N    Health points:  ")
				print (player.item.hp)
				print ("%N    Is alive: ")
				print (player.item.alive)
				print ("%N    Position of square in board: ")
				if board.players_placement.at (player.item) = 0 then
					print ("The player landed beyond the board")
				else
					print (board.players_placement.item(player.item))
				end
				print ("%N%N")
			end
		end

	is_game_over: BOOLEAN
			-- Boolean returning true if the game is over
		do
			Result := board.player_outside_board
		end

feature -- Element change

	roll_dice
			-- Roll dice and set the last_roll value
		require
			dice_not_empty: not dice.is_empty
		do
			last_roll := 0
			across dice as die
			loop
				die.item.roll
				last_roll := last_roll + die.item.last_roll
			end
		end

feature -- Miscellaneous

	execute_effect (player: PLAYER)
			-- Execute an effect on the player, given by the rules of the game
		require
			player_present: players.has (player)
		do
			inspect board.players_placement.item (player)
			when 10, 20, 30, 40, 50 then
				player.fall_in_trap
			when 5, 15, 25, 35, 45 then
				player.heal
			else
			end
		end

	run
			-- run a game loop, that terminates when is_game_over evaluates to true
		do
			from

			until
				is_game_over
			loop

				across players as player loop
					if player.item.alive then
						roll_dice
						board.move_player (player.item, last_roll)
						execute_effect (player.item)
					end
				end

			end
			display_players_in_game
		ensure
			game_over: is_game_over
		end

end
