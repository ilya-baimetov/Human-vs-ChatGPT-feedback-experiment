note
	description: "Summary description for {BOARD_GAME}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BOARD_GAME

create
	make

feature {NONE} -- Initialization

	make
		-- Initialize the game
	do
		create players.make (0)
		create dice1
		create dice2
	end

feature

	players: ARRAYED_LIST [PLAYER]
		-- A list of players in the game

	dice1: DICE
		-- The first dice

	dice2: DICE
		-- The second dice

feature

	init_game
		-- Initialize the game
		do
			players.wipe_out
		end

	add_player (p: PLAYER)
		-- Add player `p' to the game
	do
		if players.count < 6 then
			players.force (p)
		else
			print ("No slot is available!")
		end
	end


	play
		-- Launch the game
	local
		round_id: INTEGER
	do

		from
			round_id := 1
		until
			is_game_end or round_id >= 20
		loop
			-- A round of the game
			print ("----------------------  Round " + round_id.out + " --------------------- %N%N")
			across players as p loop
				if not p.item.has_reached_end_square then
					p.item.play (dice1, dice2)
				end
			end
			round_id := round_id + 1
			print_results
		end

		print ("=================== Game Ended ==================== %N%N")
		print_results
	end

	is_game_end: BOOLEAN
		-- Is the game reach ending condition?
	do
		Result := across players as p all (not p.item.is_alive or p.item.position >= 50) end
	end

	print_results
	local
		result_str: STRING
	do
		result_str := ""
		result_str.append ("Name%TPosition%TPoint%N")

		across players as p loop
			result_str.append (p.item.name + "%T" + p.item.position.out +  "%T%T" + p.item.point.out + "%N")
		end

		print (result_str + "%N")
	end


end
