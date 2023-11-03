note
	description: "This {BOARD} class handles the players' placement in the board and the representation of the board as an array of squares."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BOARD

create
	make

feature -- Initialization

	make (players: ARRAY [PLAYER])
			-- Instantiate the board
		require
			players_valid_number: players /= Void and then players.count >= 2 and players.count <= 6
		do
			player_outside_board := false
			init_squares
			init_placement (players)
		ensure
			players_all_placed: players.count = players_placement.count
			player_inside_board: player_outside_board = false
		end

feature {NONE} -- Initialization

	init_squares
		local
			square: SQUARE
			number_of_squares: INTEGER
		do
			number_of_squares := 50
			create squares.make_empty
			across 1 |..| number_of_squares as index
			loop
				create square.set_id (index.item)
				squares.force (square, index.item)
			end
		ensure
			board_of_50_squares: squares.count = 50
		end

	init_placement (players: ARRAY [PLAYER])
		local
			position: INTEGER
		do
			position := 1
			create players_placement.make (players.count)
			across players as player
			loop
				players_placement.extend (position, player.item)
			end
		ensure
			players_placed: players.count = players_placement.count
		end

feature -- Access

	player_outside_board: BOOLEAN
			-- Returns true if a player landed outside the board

	players_placement: HASH_TABLE [INTEGER, PLAYER]
			-- Table that associates to each player its position on the array of squares or 0 if the player landed beyond the board

	squares: ARRAY [SQUARE]
			-- Array of squares
feature -- Element change

	move_player (a_player: PLAYER; steps: INTEGER)
			-- Move a given player of the given steps on the board
		require
			non_trivial_move: steps > 0
		local
			current_position: INTEGER
		do
			current_position := players_placement.item (a_player)
			if current_position + steps < squares.count then
				players_placement.item (a_player) := current_position + steps
			else
				players_placement.item (a_player) := 0
				player_outside_board := true
			end
		ensure
			position_changed: players_placement.at (a_player) /= old players_placement.at (a_player)
			player_outside_board_placement: players_placement.at (a_player) = 0 implies player_outside_board
			position_in_board: not (players_placement.at (a_player) = 0) implies players_placement.at (a_player) >= 1 and players_placement.at (a_player) <= squares.count
		end

end
