class
	GAME

create
	make

feature
	Initial_hp: INTEGER = 15
	Max_hp: INTEGER = 15
	Last_cell_position: INTEGER = 50

	make (a_players: INTEGER)
		local
			i: INTEGER
		do
			create players.make_filled (create {PLAYER}.make (Initial_hp, Max_hp, "p1"), 1, a_players)
			from
				i := 2
			until
				i > a_players
			loop
				players [i] := create {PLAYER}.make (Initial_hp, Max_hp, "p" + i.out)
				i := i + 1
			end

			create positions.make_filled (1, 1, a_players)

			create dice.make (2)
		end

feature

	dice: DICE

	play_game
		do
			from

			until
				is_finished
			loop
				play_round
			end
		end

	play_round
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > players.count
			loop
				if not is_player_eliminated (players [i]) then
					dice.roll
					positions [i] := positions [i] + dice.last_roll
					cell_action_at (positions [i]).call (players [i])
				end
				i := i + 1
			end
		end

	cell_action_at (i: INTEGER): PROCEDURE [PLAYER]
		do
			if 10 <= i and i <= 50 and i \\ 10 = 0 then
				Result := damage_cell_action
			elseif 5 <= i and i <= 45 and i \\ 10 = 5 then
				Result := heal_cell_action
			else
				Result := regular_cell_action
			end
		end

	regular_cell_action: PROCEDURE [PLAYER]
		once
			Result := agent (p: PLAYER) do end
		end

	Heal_cell_amount: INTEGER = 5
	heal_cell_action: PROCEDURE [PLAYER]
		once
			Result := agent (p: PLAYER)
					do
						p.heal (Heal_cell_amount)
					end
		end

	Damage_cell_amount: INTEGER = 5
	damage_cell_action: PROCEDURE [PLAYER]
		once
			Result := agent (p: PLAYER)
					do
						p.damage (Damage_cell_amount)
					end
		end

feature
	is_player_eliminated (p: PLAYER): BOOLEAN
		do
			Result := p.hp < 0
		end

	is_finished: BOOLEAN
		do
			Result := ∃ pos: positions ¦ pos > Last_cell_position
					or ∀ p: players ¦ is_player_eliminated (p)
		end

feature
	players: ARRAY [PLAYER]
	positions: ARRAY [INTEGER]

end
